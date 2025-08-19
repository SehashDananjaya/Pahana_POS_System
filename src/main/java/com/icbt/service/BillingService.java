package com.icbt.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.icbt.dao.DBConnectionFactory;
import com.icbt.model.Bill;
import com.icbt.model.BillItem;


public class BillingService {
    private static BillingService instance;
    
    private BillingService() {}
    
    public static BillingService getInstance() {
        if (instance == null) {
            instance = new BillingService();
        }
        return instance;
    }

    public boolean saveBillItem(BillItem billItem) {
        String sql = "INSERT INTO billitems (bill_id, item_id, quantity, unit_price, subtotal) "
                   + "VALUES (?, ?, ?, ?, ?)";

        // Use try-with-resources to safely handle resources
        try  {
        	Connection conn = DBConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Set values from BillItem object
            stmt.setInt(1, billItem.getBillId());
            stmt.setInt(2, billItem.getItemId());
            stmt.setInt(3, billItem.getQuantity());
            stmt.setDouble(4, billItem.getUnitPrice());
            stmt.setDouble(5, billItem.getSubtotal());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteBillItemsByBillId(int billId) {
        String sql = "DELETE FROM billitems WHERE bill_id = ?";
        
        try {
            Connection conn = DBConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, billId);

            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public double getTotalAmountByBillId(int billId) {
        double total = 0.0;
        String sql = "SELECT SUM(subtotal) AS total FROM billitems WHERE bill_id = ?";
        
        try  {
        	Connection conn = DBConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                total = rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    
    public void saveFinalBill(int billId, double totalAmount) throws SQLException {
        String sql = "UPDATE bills SET total_amount = ? WHERE bill_id = ?";
        Connection conn = DBConnectionFactory.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setDouble(1, totalAmount);
        stmt.setInt(2, billId);
        stmt.executeUpdate();
    }
    
    public int saveBillAndGetId(Bill bill) throws SQLException {
        String sql = "INSERT INTO bills (customer_id, bill_date) VALUES (?, ?)";

        try {
        	Connection conn = DBConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Set values
            stmt.setInt(1, bill.getCustomerId());
            stmt.setDate(2, bill.getBillDate());

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // return the generated bill_id
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // return -1 if something went wrong
    }
    
    public List<BillItem> getBillItemsByBillId2(int billId) {
        List<BillItem> billItems = new ArrayList<>();
        String sql = "SELECT bi.bill_item_id, bi.bill_id, bi.item_id, bi.quantity, bi.unit_price, bi.subtotal, "
                   + "p.item_name, p.item_description "
                   + "FROM bill_item bi "
                   + "JOIN product p ON bi.item_id = p.product_id "
                   + "WHERE bi.bill_id = ?";

        try  {
        	Connection conn = DBConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BillItem item = new BillItem();
                item.setBillItemId(rs.getInt("bill_item_id"));
                item.setBillId(rs.getInt("bill_id"));
                item.setItemId(rs.getInt("item_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getDouble("unit_price"));
                item.setSubtotal(rs.getDouble("subtotal"));
                item.setItemName(rs.getString("item_name"));
                item.setItemDescription(rs.getString("item_description"));

                billItems.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return billItems;
    }
    
//    public List<BillItem> getBillItemsByBillId(int billId) throws SQLException {
//        List<BillItem> billItems = new ArrayList<>();
//        String sql = "SELECT * FROM billitems WHERE bill_id = ?";
//
//        try (Connection conn = DBConnectionFactory.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//
//            stmt.setInt(1, billId);
//            try (ResultSet rs = stmt.executeQuery()) {
//                while (rs.next()) {
//                    BillItem item = new BillItem();
//                    item.setBillId(rs.getInt("bill_id"));
//                    item.setItemId(rs.getInt("item_id"));
//                    item.setQuantity(rs.getInt("quantity"));
//                    item.setUnitPrice(rs.getDouble("unit_price"));
//                    item.setSubtotal(rs.getDouble("subtotal"));
//                    billItems.add(item);
//                }
//            }
//        }
//        return billItems;
//    }
//    
    public List<BillItem> getBillItemsByBillId3(int billId) throws SQLException {
        List<BillItem> billItems = new ArrayList<>();
        String sql = "SELECT bi.*, i.name AS itemName " +
                     "FROM billitems bi " +
                     "JOIN product i ON bi.item_id = i.product_id " +
                     "WHERE bi.bill_id = ?";

        try  {
        	Connection conn = DBConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    BillItem item = new BillItem();
                    item.setBillItemId(rs.getInt("bill_item_id")); // assuming column name
                    item.setBillId(rs.getInt("bill_id"));
                    item.setItemId(rs.getInt("item_id"));
                    item.setItemName(rs.getString("itemName"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getDouble("unit_price"));
                    item.setSubtotal(rs.getDouble("subtotal"));
                    billItems.add(item);
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return billItems;
    }
    
    public boolean deleteBillItem(int billItemId) {
        String query = "DELETE FROM billitems WHERE bill_item_id = ?";
        boolean deleted = false;

        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, billItemId);

            int rowsAffected = statement.executeUpdate();
            deleted = rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deleted;
    }
    
    
    
    
    
    
    // Generate a new bill
   
    // Update item stock after billing
//    private void updateItemStock(Connection connection, int itemId, int quantitySold) throws SQLException {
//        String sql = "UPDATE items SET quantity = quantity - ? WHERE product_id = ?";
//        try (PreparedStatement statement = connection.prepareStatement(sql)) {
//            statement.setInt(1, quantitySold);
//            statement.setInt(2, itemId);
//            statement.executeUpdate();
//        }
//    }

    // Get all bills
//    public List<Bill> getAllBills() throws SQLException {
//        List<Bill> bills = new ArrayList<>();
//        Connection connection = null;
//        PreparedStatement statement = null;
//        ResultSet resultSet = null;
//        
//        try {
//            connection = DBConnectionFactory.getConnection();
//            String sql = "SELECT b.*, c.name as customer_name, c.address as customer_address, " +
//                        "c.telephone as customer_phone, c.email as customer_email " +
//                        "FROM bills b JOIN customers c ON b.customer_id = c.id " +
//                        "ORDER BY b.bill_date DESC, b.bill_id DESC";
//            
//            statement = connection.prepareStatement(sql);
//            resultSet = statement.executeQuery();
//            
//            while (resultSet.next()) {
//                Bill bill = new Bill();
//                bill.setBillId(resultSet.getInt("bill_id"));
//                bill.setCustomerId(resultSet.getInt("customer_id"));
//                bill.setBillDate(resultSet.getString("bill_date"));
//                bill.setTotalAmount(resultSet.getDouble("total_amount"));
//                bill.setCustomerName(resultSet.getString("customer_name"));
//                bill.setCustomerAddress(resultSet.getString("customer_address"));
//                bill.setCustomerPhone(resultSet.getString("customer_phone"));
//                bill.setCustomerEmail(resultSet.getString("customer_email"));
//                bills.add(bill);
//            }
//        } finally {
//            closeResources(resultSet, statement, connection);
//        }
//        
//        return bills;
//    }

    // Get bill by ID
//    public Bill getBillById(int billId) throws SQLException {
//        Bill bill = null;
//        Connection connection = null;
//        PreparedStatement statement = null;
//        ResultSet resultSet = null;
//        
//        try {
//            connection = DBConnectionFactory.getConnection();
//            String sql = "SELECT b.*, c.name as customer_name, c.address as customer_address, " +
//                        "c.telephone as customer_phone, c.email as customer_email " +
//                        "FROM bills b JOIN customers c ON b.customer_id = c.id " +
//                        "WHERE b.bill_id = ?";
//            
//            statement = connection.prepareStatement(sql);
//            statement.setInt(1, billId);
//            resultSet = statement.executeQuery();
//            
//            if (resultSet.next()) {
//                bill = new Bill();
//                bill.setBillId(resultSet.getInt("bill_id"));
//                bill.setCustomerId(resultSet.getInt("customer_id"));
//                bill.setBillDate(resultSet.getString("bill_date"));
//                bill.setTotalAmount(resultSet.getDouble("total_amount"));
//                bill.setCustomerName(resultSet.getString("customer_name"));
//                bill.setCustomerAddress(resultSet.getString("customer_address"));
//                bill.setCustomerPhone(resultSet.getString("customer_phone"));
//                bill.setCustomerEmail(resultSet.getString("customer_email"));
//                
//                // Load bill items
//                bill.setBillItems(getBillItemsByBillId(billId));
//            }
//        } finally {
//            closeResources(resultSet, statement, connection);
//        }
//        
//        return bill;
//    }

    // Get bill items by bill ID
 
    // Get bills by customer ID
//    public List<Bill> getBillsByCustomerId(int customerId) throws SQLException {
//        List<Bill> bills = new ArrayList<>();
//        Connection connection = null;
//        PreparedStatement statement = null;
//        ResultSet resultSet = null;
//        
//        try {
//            connection = DBConnectionFactory.getConnection();
//            String sql = "SELECT b.*, c.name as customer_name, c.address as customer_address, " +
//                        "c.telephone as customer_phone, c.email as customer_email " +
//                        "FROM bills b JOIN customers c ON b.customer_id = c.id " +
//                        "WHERE b.customer_id = ? ORDER BY b.bill_date DESC";
//            
//            statement = connection.prepareStatement(sql);
//            statement.setInt(1, customerId);
//            resultSet = statement.executeQuery();
//            
//            while (resultSet.next()) {
//                Bill bill = new Bill();
//                bill.setBillId(resultSet.getInt("bill_id"));
//                bill.setCustomerId(resultSet.getInt("customer_id"));
//                bill.setBillDate(resultSet.getString("bill_date"));
//                bill.setTotalAmount(resultSet.getDouble("total_amount"));
//                bill.setCustomerName(resultSet.getString("customer_name"));
//                bill.setCustomerAddress(resultSet.getString("customer_address"));
//                bill.setCustomerPhone(resultSet.getString("customer_phone"));
//                bill.setCustomerEmail(resultSet.getString("customer_email"));
//                bills.add(bill);
//            }
//        } finally {
//            closeResources(resultSet, statement, connection);
//        }
//        
//        return bills;
//    }
//
//    // Get bills by date
//    public List<Bill> getBillsByDate(String date) throws SQLException {
//        List<Bill> bills = new ArrayList<>();
//        Connection connection = null;
//        PreparedStatement statement = null;
//        ResultSet resultSet = null;
//        
//        try {
//            connection = DBConnectionFactory.getConnection();
//            String sql = "SELECT b.*, c.name as customer_name, c.address as customer_address, " +
//                        "c.telephone as customer_phone, c.email as customer_email " +
//                        "FROM bills b JOIN customers c ON b.customer_id = c.id " +
//                        "WHERE b.bill_date = ? ORDER BY b.bill_id DESC";
//            
//            statement = connection.prepareStatement(sql);
//            statement.setString(1, date);
//            resultSet = statement.executeQuery();
//            
//            while (resultSet.next()) {
//                Bill bill = new Bill();
//                bill.setBillId(resultSet.getInt("bill_id"));
//                bill.setCustomerId(resultSet.getInt("customer_id"));
//                bill.setBillDate(resultSet.getString("bill_date"));
//                bill.setTotalAmount(resultSet.getDouble("total_amount"));
//                bill.setCustomerName(resultSet.getString("customer_name"));
//                bill.setCustomerAddress(resultSet.getString("customer_address"));
//                bill.setCustomerPhone(resultSet.getString("customer_phone"));
//                bill.setCustomerEmail(resultSet.getString("customer_email"));
//                bills.add(bill);
//            }
//        } finally {
//            closeResources(resultSet, statement, connection);
//        }
//        
//        return bills;
//    }
//
//    // Get total sales for a specific date
//    public double getTotalSalesByDate(String date) throws SQLException {
//        Connection connection = null;
//        PreparedStatement statement = null;
//        ResultSet resultSet = null;
//        double totalSales = 0;
//        
//        try {
//            connection = DBConnectionFactory.getConnection();
//            String sql = "SELECT SUM(total_amount) as total_sales FROM bills WHERE bill_date = ?";
//            
//            statement = connection.prepareStatement(sql);
//            statement.setString(1, date);
//            resultSet = statement.executeQuery();
//            
//            if (resultSet.next()) {
//                totalSales = resultSet.getDouble("total_sales");
//            }
//        } finally {
//            closeResources(resultSet, statement, connection);
//        }
//        
//        return totalSales;
//    }
//
//    // Get total sales for a date range
//    public double getTotalSalesByDateRange(String fromDate, String toDate) throws SQLException {
//        Connection connection = null;
//        PreparedStatement statement = null;
//        ResultSet resultSet = null;
//        double totalSales = 0;
//        
//        try {
//            connection = DBConnectionFactory.getConnection();
//            String sql = "SELECT SUM(total_amount) as total_sales FROM bills WHERE bill_date BETWEEN ? AND ?";
//            
//            statement = connection.prepareStatement(sql);
//            statement.setString(1, fromDate);
//            statement.setString(2, toDate);
//            resultSet = statement.executeQuery();
//            
//            if (resultSet.next()) {
//                totalSales = resultSet.getDouble("total_sales");
//            }
//        } finally {
//            closeResources(resultSet, statement, connection);
//        }
//        
//        return totalSales;
//    }
//
//    // Delete bill (for admin purposes)
//    public boolean deleteBill(int billId) throws SQLException {
//        Connection connection = null;
//        PreparedStatement billItemsStatement = null;
//        PreparedStatement billStatement = null;
//        boolean success = false;
//        
//        try {
//            connection = DBConnectionFactory.getConnection();
//            connection.setAutoCommit(false);
//            
//            // First delete bill items
//            String deleteBillItemsSql = "DELETE FROM bill_items WHERE bill_id = ?";
//            billItemsStatement = connection.prepareStatement(deleteBillItemsSql);
//            billItemsStatement.setInt(1, billId);
//            billItemsStatement.executeUpdate();
//            
//            // Then delete bill
//            String deleteBillSql = "DELETE FROM bills WHERE bill_id = ?";
//            billStatement = connection.prepareStatement(deleteBillSql);
//            billStatement.setInt(1, billId);
//            int rowsAffected = billStatement.executeUpdate();
//            
//            if (rowsAffected > 0) {
//                connection.commit();
//                success = true;
//            }
//        } catch (SQLException e) {
//            if (connection != null) {
//                connection.rollback();
//            }
//            throw e;
//        } finally {
//            if (connection != null) {
//                connection.setAutoCommit(true);
//            }
//            if (billItemsStatement != null) billItemsStatement.close();
//            closeResources(null, billStatement, connection);
//        }
//        
//        return success;
//    }
//
//    // Utility method to close resources
//    private void closeResources(ResultSet resultSet, PreparedStatement statement, Connection connection) {
//        try {
//            if (resultSet != null) resultSet.close();
//            if (statement != null) statement.close();
//            if (connection != null) connection.close();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
}