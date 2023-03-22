/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plantshop.dao;

import com.plantshop.dto.Plant;
import com.plantshop.utils.DBUtils;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author DELL
 */
public class PlantDAO {

    public static ArrayList<Plant> getPlants(String keyword, String searchBy) {
        ArrayList<Plant> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null && searchBy != null) {
                String sql = "SELECT PID, PName, price, imgPath, description, status, Plants.CateID as 'CateID', CateName\n"
                        + "FROM Plants JOIN Categories ON Plants.CateID = Categories.CateID\n";
                if (searchBy.equalsIgnoreCase("Search by name")) {
                    sql += "WHERE Plants.PName like ?";
                } else {
                    sql += "WHERE CateName like ?";
                }
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("PID");
                        String name = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgPath = rs.getString("imgPath");
                        String description = rs.getString("description");
                        int status = rs.getInt("status");
                        int cateId = rs.getInt("CateID");
                        String cateName = rs.getString("CateName");
                        Plant plant = new Plant(id, name, price, imgPath, description, status, cateId, cateName);
                        list.add(plant);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static Plant getPlantDetail(int plantID) {
        Plant kq = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT PID, PName, price, imgPath, description, status, Plants.CateID as 'CateID', CateName\n"
                        + "FROM Plants JOIN Categories ON Plants.CateID = Categories.CateID\n"
                        + "WHERE PID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, plantID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("PID");
                        String name = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgPath = rs.getString("imgPath");
                        String description = rs.getString("description");
                        int status = rs.getInt("status");
                        int cateId = rs.getInt("CateID");
                        String cateName = rs.getString("CateName");
                        kq = new Plant(id, name, price, imgPath, description, status, cateId, cateName);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kq;
    }

    public static ArrayList<Plant> getPlantsByAdmin(String keyword) throws Exception {
        ArrayList<Plant> kq = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "SELECT PID, PName, price, imgPath, description, status, CateID\n"
                    + "FROM Plants\n";
            if (keyword != null) {
                s += "WHERE PName LIKE ?";
            }
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, "%" + keyword + "%");
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    int id = rs.getInt("PID");
                    String name = rs.getString("PName");
                    int price = rs.getInt("price");
                    String imgPath = rs.getString("imgPath");
                    String description = rs.getString("description");
                    int status = rs.getInt("status");
                    int cateId = rs.getInt("CateID");
                    Plant plant = new Plant(id, name, price, imgPath, description, status, cateId);
                    kq.add(plant);
                }
            }
            cn.close();
        }
        return kq;
    }

    public static int insertPlant(String name, int price, String imgPath, String description, int status, int cateId) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "insert Plants(PName, price, imgPath, description, status, CateID)\n"
                    + " values (?,?,?,?,?,?)";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, name);
            pst.setInt(2, price);
            pst.setString(3, imgPath);
            pst.setString(4, description);
            pst.setInt(5, status);
            pst.setInt(6, cateId);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }

    public static int updatePlant(int id, int price, String imgPath, String description) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "UPDATE Plants\n"
                    + "SET price = ?, imgPath = ?, description = ?\n"
                    + "WHERE PID = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setInt(1, price);
            pst.setString(2, imgPath);
            pst.setString(3, description);
            pst.setInt(4, id);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }
    
    public static int updatePlantStatus(int id, int status) throws Exception  {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "UPDATE Plants\n"
                    + "SET status= ?\n"
                    + "WHERE PID = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setInt(1, status);
            pst.setInt(2, id);
            kq = pst.executeUpdate();
        } 
        cn.close();
        return kq;
    }
}
