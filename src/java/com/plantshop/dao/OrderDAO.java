/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plantshop.dao;

import com.plantshop.dto.Order;
import com.plantshop.dto.OrderDetail;
import com.plantshop.utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

/**
 *
 * @author DELL
 */
public class OrderDAO {

    public static ArrayList<Order> getOrders(String email) throws Exception {
        ArrayList<Order> list = new ArrayList<>();
        try {
            Connection cn = DBUtils.makeConnection();
            if (cn != null) {
                String s = "SELECT Orders.OrderID, Orders.OrdDate, Orders.shipdate, Orders.status, Orders.accID\n"
                        + "FROM Orders JOIN Accounts ON Orders.accID = Accounts.accID\n"
                        + "WHERE Accounts.email = ?";
                PreparedStatement pst = cn.prepareStatement(s);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int orderId = rs.getInt("OrderID");
                        String orderDate = rs.getString("OrdDate");
                        String shipDate = rs.getString("shipdate");
                        int status = rs.getInt("status");
                        int accId = rs.getInt("accID");
                        Order ord = new Order(orderId, orderDate, shipDate, status, accId);
                        list.add(ord);
                    }
                }
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static int orderAgain(int orderId) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "UPDATE Orders\n"
                    + "SET status = 1\n"
                    + "WHERE OrderID = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setInt(1, orderId);
            kq = pst.executeUpdate();
        }
        return kq;
    }

    public static int cancelOrder(int orderId) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "UPDATE Orders\n"
                    + "SET status = 3\n"
                    + "WHERE OrderID = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setInt(1, orderId);
            kq = pst.executeUpdate();
        }
        return kq;
    }

    public static ArrayList<OrderDetail> getOrderDetail(int orderID) throws Exception {
        ArrayList<OrderDetail> list = new ArrayList<>();
        try {
            Connection cn = DBUtils.makeConnection();
            if (cn != null) {
                String s = "SELECT DetailID, OrderID, PID, PName, price, imgPath, quantity\n"
                        + "FROM OrderDetails, Plants\n"
                        + "WHERE OrderID = ? and OrderDetails.FID = Plants.PID";
                PreparedStatement pst = cn.prepareStatement(s);
                pst.setInt(1, orderID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int detailId = rs.getInt("DetailID");
                        int orderId = rs.getInt("OrderID");
                        int plantId = rs.getInt("PID");
                        String plantName = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgPath = rs.getString("imgPath");
                        int quantity = rs.getInt("quantity");
                        OrderDetail orderDetail = new OrderDetail(detailId, orderId, plantId, plantName, price, imgPath, quantity);
                        list.add(orderDetail);
                    }
                }
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean insertOrder(String email, HashMap<String, Integer> cart) {
        Connection cn = null;
        boolean result = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                int accId = 0, orderId = 0;
                cn.setAutoCommit(false);
                String sql = "SELECT accID from Accounts where Accounts.email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    accId = rs.getInt("accID");
                }
                System.out.println("Account ID: " + accId);
                Date d = new Date(System.currentTimeMillis());
                System.out.println("Order date: " + d);
                sql = "INSERT Orders(OrdDate,status,accID) values (?,?,?)";
                pst = cn.prepareStatement(sql);
                pst.setDate(1, d);
                pst.setInt(2, 1);
                pst.setInt(3, accId);
                pst.executeUpdate();
                //Get order ID that is the largest number
                sql = "SELECT TOP 1 OrderID from Orders order by OrderID desc";
                pst = cn.prepareStatement(sql);
                rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    orderId = rs.getInt("OrderID");
                }
                //Insert order details
                System.out.println("Order ID: " + orderId);
                Set<String> pids = cart.keySet();
                for (String pid : pids) {
                    sql = "insert OrderDetails values (?,?,?)";
                    pst = cn.prepareStatement(sql);
                    pst.setInt(1, orderId);
                    pst.setInt(2, Integer.parseInt(pid.trim()));
                    pst.setInt(3, cart.get(pid));
                    pst.executeUpdate();
                    cn.commit();
                    cn.setAutoCommit(true);
                }
                return true;
            } else {
                System.out.println("Cannot add Order! Please try again");
            }
        } catch (Exception e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            result = false;
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public static ArrayList<Order> getOrdersByAdmin(String keyword) throws Exception {
        ArrayList<Order> kq = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "SELECT OrderID, OrdDate, shipdate, Orders.status, Orders.accID, Accounts.fullname\n"
                    + "FROM Orders JOIN Accounts ON Orders.accID = Accounts.accID\n";
            if (keyword != null) {
                s += "WHERE Accounts.fullname LIKE ?";
            }
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, "%" + keyword + "%");
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    int orderId = rs.getInt("OrderID");
                    String orderDate = rs.getString("OrdDate");
                    String shipDate = rs.getString("shipdate");
                    int status = rs.getInt("status");
                    int accId = rs.getInt("accID");
                    String accName = rs.getString("fullname");
                    Order ord = new Order(orderId, orderDate, shipDate, status, accId, accName);
                    kq.add(ord);
                }
            }
            cn.close();
        }
        return kq;
    }

    public static ArrayList<Order> getFilteredOrdersByAdmin(Date fromDate, Date toDate) throws Exception {
        ArrayList<Order> kq = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "SELECT OrderID, OrdDate, shipdate, Orders.status, Orders.accID, Accounts.fullname\n"
                    + "FROM Orders JOIN Accounts ON Orders.accID = Accounts.accID\n";
            if (fromDate != null && toDate != null) {
                s += "WHERE OrdDate BETWEEN ? AND ?";
            }
            PreparedStatement pst = cn.prepareStatement(s);
            if (fromDate != null && toDate != null) {
                pst.setDate(1, fromDate);
                pst.setDate(2, toDate);
            }
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    int orderId = rs.getInt("OrderID");
                    String orderDate = rs.getString("OrdDate");
                    String shipDate = rs.getString("shipdate");
                    int status = rs.getInt("status");
                    int accId = rs.getInt("accID");
                    String accName = rs.getString("fullname");
                    Order ord = new Order(orderId, orderDate, shipDate, status, accId, accName);
                    kq.add(ord);
                }
            }
            cn.close();
        }
        return kq;
    }

    public static ArrayList<Order> getFilteredOrders(String email, Date fromDate, Date toDate) throws Exception {
        ArrayList<Order> kq = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "SELECT OrderID, OrdDate, shipdate, Orders.status, Orders.accID, Accounts.fullname\n"
                    + "FROM Orders JOIN Accounts ON Orders.accID = Accounts.accID\n";
            if (fromDate != null && toDate != null) {
                s += "WHERE OrdDate BETWEEN ? AND ? AND Accounts.email = ?";
            }
            PreparedStatement pst = cn.prepareStatement(s);
            if (fromDate != null && toDate != null) {
                pst.setDate(1, fromDate);
                pst.setDate(2, toDate);
                pst.setString(3, email);
            }
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    int orderId = rs.getInt("OrderID");
                    String orderDate = rs.getString("OrdDate");
                    String shipDate = rs.getString("shipdate");
                    int status = rs.getInt("status");
                    int accId = rs.getInt("accID");
                    String accName = rs.getString("fullname");
                    Order ord = new Order(orderId, orderDate, shipDate, status, accId, accName);
                    kq.add(ord);
                }
            }
            cn.close();
        }
        return kq;
    }

    public static ArrayList<Order> getFilteredOrders(String email, Date fromDate, Date toDate, String[] checkboxValues) throws Exception {
        String checkMark = "";
        for (int i = 0; i < checkboxValues.length; i++) {
            if (checkboxValues[i].equals("process")) checkMark += "1";
            if (checkboxValues[i].equals("complete")) checkMark += "2";
            if (checkboxValues[i].equals("cancel")) checkMark += "3";
        }
        String delimiter = ",";
        String result = String.join(delimiter, checkMark.split(""));
        ArrayList<Order> kq = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "SELECT OrderID, OrdDate, shipdate, Orders.status, Orders.accID, Accounts.fullname\n"
                    + "FROM Orders JOIN Accounts ON Orders.accID = Accounts.accID\n";
            if (fromDate != null && toDate != null) {
                s += "WHERE OrdDate BETWEEN ? AND ? AND Accounts.email = ?\n";
            }
            if (!checkMark.equals("")) {
                s += "AND Orders.status IN (" + result + ")";
            }
            PreparedStatement pst = cn.prepareStatement(s);
            if (fromDate != null && toDate != null) {
                pst.setDate(1, fromDate);
                pst.setDate(2, toDate);
                pst.setString(3, email);
            }
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    int orderId = rs.getInt("OrderID");
                    String orderDate = rs.getString("OrdDate");
                    String shipDate = rs.getString("shipdate");
                    int status = rs.getInt("status");
                    int accId = rs.getInt("accID");
                    String accName = rs.getString("fullname");
                    Order ord = new Order(orderId, orderDate, shipDate, status, accId, accName);
                    kq.add(ord);
                }
            }
            cn.close();
        }
        return kq;
    }

    public static int deleteOrder(int id) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "DELETE FROM Orders\n"
                    + "WHERE accID = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setInt(1, id);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }

    public static int deleteOrderByAdmin(int id) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "DELETE FROM Orders\n"
                    + "WHERE OrderID = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setInt(1, id);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }

    public static int completeOrderStatus(int id, int status, String shipDate) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "UPDATE Orders\n"
                    + "SET status= ?, shipdate= ?\n"
                    + "WHERE OrderID = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setInt(1, status);
            pst.setString(2, shipDate);
            pst.setInt(3, id);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }

    public static int cancelOrderStatus(int id, int status) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "UPDATE Orders\n"
                    + "SET status= ?\n"
                    + "WHERE OrderID = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setInt(1, status);
            pst.setInt(2, id);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }
}
