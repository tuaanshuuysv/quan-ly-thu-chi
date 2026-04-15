package com.store.model;

import java.sql.Date;

public class Transaction {
    private int id;
    private double amount;
    private Date transactionDate;
    private String note;
    private int categoryId;
    private int userId;

    public Transaction() {}

    public Transaction(int id, double amount, Date transactionDate, String note, int categoryId, int userId) {
        this.id = id;
        this.amount = amount;
        this.transactionDate = transactionDate;
        this.note = note;
        this.categoryId = categoryId;
        this.userId = userId;
    }

    // --- GETTER VÀ SETTER ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public Date getTransactionDate() { return transactionDate; }
    public void setTransactionDate(Date transactionDate) { this.transactionDate = transactionDate; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}