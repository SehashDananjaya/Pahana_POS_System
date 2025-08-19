package com.icbt.service;

import com.icbt.dao.BillingDAO;
import com.icbt.model.Bill;
import com.icbt.model.BillItem;

import java.sql.SQLException;
import java.util.List;

public class BillingService {

    private static volatile BillingService instance;  
    private BillingDAO billingDAO;

    private BillingService() {
        this.billingDAO = new BillingDAO();
    }

    public static BillingService getInstance() {
        if (instance == null) {
            synchronized (BillingService.class) {
                if (instance == null) {
                    instance = new BillingService();
                }
            }
        }
        return instance;
    }

    // ------------------ Service Methods ------------------

    public boolean saveBillItem(BillItem billItem) {
        return billingDAO.saveBillItem(billItem);
    }

    public boolean deleteBillItemsByBillId(int billId) {
        return billingDAO.deleteBillItemsByBillId(billId);
    }

    public double getTotalAmountByBillId(int billId) {
        return billingDAO.getTotalAmountByBillId(billId);
    }

    public void saveFinalBill(int billId, double totalAmount) throws SQLException {
        billingDAO.saveFinalBill(billId, totalAmount);
    }

    public int saveBillAndGetId(Bill bill) throws SQLException {
        return billingDAO.saveBillAndGetId(bill);
    }

   

    public List<BillItem> getBillItemsByBillId3(int billId) throws SQLException {
        return billingDAO.getBillItemsByBillId3(billId);
    }

    public boolean deleteBillItem(int billItemId) {
        return billingDAO.deleteBillItem(billItemId);
    }

    public void updateCustomerUnits(String customerName, int units) {
        billingDAO.updateCustomerUnits(customerName, units);
    }
}
