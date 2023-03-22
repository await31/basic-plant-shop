package com.plantshop.dao;

import com.plantshop.dto.Account;
import com.plantshop.utils.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class AccountDAO {

    public static Account getAccount(String accountid, String password) throws Exception {
        Connection cn = null;
        Account kq = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT accID, email, password, fullname, phone, status, role \n"
                        + "FROM Accounts\n"
                        + "WHERE status = 1 and email=? and password =? COLLATE Latin1_General_CS_AI";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, accountid);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    String AccID = rs.getString("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String Fullname = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");
                    kq = new Account(AccID, Email, Password, Fullname, Phone, Status, Role);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return kq;
    }

    public static Account getAccount(String email) throws Exception {
        Account kq = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "SELECT accID, email, password, fullname, phone, status, role\n"
                    + "FROM Accounts\n"
                    + "WHERE email = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, email);
            ResultSet table = pst.executeQuery();
            if (table != null) {
                while (table.next()) {
                    String id = table.getString("accID");
                    String Email = table.getString("email");
                    String password = table.getString("password");
                    String fullName = table.getString("fullname");
                    String phone = table.getString("phone");
                    int status = table.getInt("status");
                    int role = table.getInt("role");
                    kq = new Account(id, Email, password, fullName, phone, status, role);
                }
            }
            cn.close();
        }
        return kq;
    }
    
    public static Account getAccountByToken(String token) throws Exception {
        Account kq = null;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "SELECT accID, email, password, fullname, phone, status, role\n"
                    + "FROM Accounts\n"
                    + "WHERE token = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, token);
            ResultSet table = pst.executeQuery();
            if (table != null) {
                while (table.next()) {
                    String id = table.getString("accID");
                    String Email = table.getString("email");
                    String password = table.getString("password");
                    String fullName = table.getString("fullname");
                    String phone = table.getString("phone");
                    int status = table.getInt("status");
                    int role = table.getInt("role");
                    kq = new Account(id, Email, password, fullName, phone, status, role);
                }
            }
            cn.close();
        }
        return kq;
    }

    //Load account to Admin page manage account
    public static ArrayList<Account> getAccountsByAdmin(String keyword) throws Exception {
        ArrayList<Account> kq = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "SELECT accID, email, password, fullname, phone, status, role\n"
                    + "FROM Accounts\n";
            if (keyword != null) {
                s += "WHERE fullname LIKE ?";
            }
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, "%" + keyword + "%");
            ResultSet table = pst.executeQuery();
            if (table != null) {
                while (table.next()) {
                    String id = table.getString("accID");
                    String Email = table.getString("email");
                    String password = table.getString("password");
                    String fullName = table.getString("fullname");
                    String phone = table.getString("phone");
                    int status = table.getInt("status");
                    int role = table.getInt("role");
                    Account acc = new Account(id, Email, password, fullName, phone, status, role);
                    kq.add(acc);
                }
            }
            cn.close();
        }
        return kq;
    }

    public static int insertAccount(String email, String password, String fullname, String phone, int status, int role) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "insert Accounts(email, password, fullname, phone, status, role)\n"
                    + " values (?,?,?,?,?,?)";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, email);
            pst.setString(2, password);
            pst.setString(3, fullname);
            pst.setString(4, phone);
            pst.setInt(5, status);
            pst.setInt(6, role);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }

    public static int changeAccountInformation(String email, String newFullName, String newPhone) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "UPDATE Accounts\n"
                    + "SET fullname = ?, phone = ?\n"
                    + "WHERE email = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, newFullName);
            pst.setString(2, newPhone);
            pst.setString(3, email);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }

    public static int updateToken(String newToken, String email) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "UPDATE Accounts\n"
                    + "SET token= ?\n"
                    + "WHERE email = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, newToken);
            pst.setString(2, email);
            kq = pst.executeUpdate();
        } 
        cn.close();
        return kq;
    }
    
    public static int updateAccountStatus(String email, int status) throws Exception  {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "UPDATE Accounts\n"
                    + "SET status= ?\n"
                    + "WHERE email = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setInt(1, status);
            pst.setString(2, email);
            kq = pst.executeUpdate();
        } 
        cn.close();
        return kq;
    }
    
    public static int deleteAccount(int id) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "DELETE FROM Accounts\n"
                    + "WHERE accID = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setInt(1, id);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }
}
