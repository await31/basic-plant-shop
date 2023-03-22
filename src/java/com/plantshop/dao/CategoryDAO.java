/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plantshop.dao;

import com.plantshop.dto.Category;
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
public class CategoryDAO {
    
  public static ArrayList<Category> getCategoriesByAdmin(String keyword) throws Exception {
        ArrayList<Category> kq = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "SELECT CateID, CateName\n"
                    + "FROM Categories\n";
            if (keyword != null) {
                s += "WHERE CateName LIKE ?";
            }
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, "%" + keyword + "%");
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    int cateId = rs.getInt("CateID");
                    String cateName = rs.getString("CateName");
                    Category cate = new Category(cateId, cateName);
                    kq.add(cate);
                }
            }
            cn.close();
        }
        return kq;
    }
  
    public static int insertCategory(String categoryName) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "insert Categories(CateName)\n"
                    + " values (?)";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, categoryName);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }
    
    public static int updateCategory(String newName, int id) throws Exception {
        int kq = 0;
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "UPDATE Categories\n"
                    + "SET CateName = ?\n"
                    + "WHERE CateID = ?";
            PreparedStatement pst = cn.prepareStatement(s);
            pst.setString(1, newName);
            pst.setInt(2, id);
            kq = pst.executeUpdate();
        }
        cn.close();
        return kq;
    }
    
    public static ArrayList<Category> getCategoriesByAdminForChoices() throws Exception {
        ArrayList<Category> kq = new ArrayList<>();
        Connection cn = DBUtils.makeConnection();
        if (cn != null) {
            String s = "SELECT CateID, CateName\n"
                    + "FROM Categories\n";
            PreparedStatement pst = cn.prepareStatement(s);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    int cateId = rs.getInt("CateID");
                    String cateName = rs.getString("CateName");
                    Category cate = new Category(cateId, cateName);
                    kq.add(cate);
                }
            }
            cn.close();
        }
        return kq;
    }
}
