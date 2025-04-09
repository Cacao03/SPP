/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import enums.UserRole;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.User;
import java.util.Optional;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Setting;

/**
 *
 * @author Đàm Quang Chiến
 */
public class UserDAO extends DBConnect {

    public ResultSet getAssignmentOfUser(int id) {
        ResultSet rs = null;
        String sql = "SELECT a.*, s.subject_code, s.subject_name, u.full_name AS created_by_name\n"
                + " FROM assignment a\n"
                + " JOIN subject s ON a.subject_id = s.subject_id\n"
                + " JOIN user u ON a.created_by = u.user_id\n"
                + " WHERE a.subject_id IN (\n"
                + "    SELECT subject_id\n"
                + "    FROM class_student cs\n"
                + "    JOIN class c ON c.class_id = cs.class_id\n"
                + "    WHERE student_id = " + id + "\n"
                + " )\n"
                + " order by due_date desc";
        rs = getData(sql);
        return rs;
    }

    public ResultSet getProjectOfUser(int id) {
        ResultSet rs = null;
        String sql = "SELECT *\n"
                + " FROM `swp391-spp`.class_student\n"
                + " join project p\n"
                + " on p.project_id = class_student.project_id\n"
                + " join class c\n"
                + " on c.class_id = p.class_id\n"
                + " join subject s\n"
                + " on s.subject_id = c.subject_id\n"
                + " join user u\n"
                + " on u.user_id = p.mentor_id\n"
                + " where student_id =  " + id + "";
        rs = getData(sql);
        return rs;
    }

    public int getNumberAssignment(int id) throws SQLException {
        ResultSet rs = null;
        int number = 0;
        String sql = "SELECT count(*)\n"
                + " FROM assignment a\n"
                + " JOIN subject s ON a.subject_id = s.subject_id\n"
                + " JOIN user u ON a.created_by = u.user_id\n"
                + " WHERE a.subject_id IN (\n"
                + "    SELECT subject_id\n"
                + "    FROM class_student cs\n"
                + "    JOIN class c ON c.class_id = cs.class_id\n"
                + "    WHERE student_id = " + id + "\n"
                + " )\n"
                + " order by due_date desc";
        rs = getData(sql);
        while (rs.next()) {
            number = rs.getInt(1);
        }
        return number;
    }

    public int getNumberProject(int id) throws SQLException {
        ResultSet rs = null;
        int number = 0;
        String sql = "SELECT count(*) \n"
                + "FROM `swp391-spp`.class_student\n"
                + "join project p\n"
                + "on p.project_id = class_student.project_id\n"
                + "where student_id = " + id + "";
        rs = getData(sql);
        while (rs.next()) {
            number = rs.getInt(1);
        }
        return number;
    }

    public int getAssignedClass(int id) throws SQLException {
        ResultSet rs = null;
        int number = 0;
        String sql = "SELECT count(*) FROM `swp391-spp`.class_student where student_id = " + id + "";
        rs = getData(sql);
        while (rs.next()) {
            number = rs.getInt(1);
        }
        return number;
    }

    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = "select * from user";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("user_id");
                String name = rs.getString("full_name");
                String email = rs.getString("email");
                String phone = rs.getString("mobile");
                String pass = rs.getString("password");
                String avt = rs.getString("avatar_url");
                int role = rs.getInt("role_id");
                String note = rs.getString("note");
                int isActive = rs.getInt("is_active");
                String accessToken = rs.getString("access_token");
                User user = new User(id, name, email, note, pass, avt, role, note, isActive, accessToken);
                list.add(user);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<User> getListStudentNoClass() {
        List<User> list = new ArrayList<>();
        String sql = "select * from user left join class_student on user.user_id = class_student.student_id where class_student.class_id is null and user.role_id = ? and user.is_active =1";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, UserRole.STUDENT.getValue());
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                list.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Optional<User> getById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean create(User user) {
        boolean result = true;
        String sql = "INSERT INTO user (full_name, email, mobile, password, role_id, is_active)\n"
                + "VALUES (?, ?, ?, ?, ?, 1);";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getFullName());
            st.setString(2, user.getEmail());
            st.setString(3, user.getMobile());
            st.setString(4, user.getPassword());
            st.setInt(5, user.getRoleId());
            result = st.executeUpdate() == 1 ? true : false;
        } catch (SQLException e) {
            System.out.println("add user fail " + e);
        }
        return result;
    }

    public boolean checkExisted(String column, String value) {
        String sql = "SELECT * FROM user WHERE " + column + " = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, value);
            ResultSet result = st.executeQuery();

            if (result.next()) {
                return true; // If there is at least one matching record, return true
            }
        } catch (SQLException e) {
            System.out.println("Error checking existence: " + e);
        }

        return false; // No matching records found
    }

    public boolean checkStudentExisted(int stId) {
        String sql = "SELECT count(*) FROM `swp391-spp`.user where user_id = ?  ;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, stId);
            ResultSet result = st.executeQuery();

            if (result.next()) {
                int count = result.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking existence: " + e);
        }

        return false; // No matching records found
    }

    public User getUserByEmailOrPhone(String column, String value) {
        // Ensure the column name is valid to prevent SQL injection
        String sql = "SELECT * FROM user WHERE " + column + " = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, value);
            ResultSet result = st.executeQuery();

            if (result.next()) {
                // Retrieve user data from the ResultSet
                int userId = result.getInt("user_id");
                String fullName = result.getString("full_name");
                String email = result.getString("email");
                String mobile = result.getString("mobile");
                String password = result.getString("password");
                String avatarUrl = result.getString("avatar_url");
                int roleId = result.getInt("role_id");
                String note = result.getString("note");
                int isActive = result.getInt("is_active");
                String accessToken = result.getString("access_token");
                // Create a User object with the retrieved data
                User user = new User(userId, fullName, email, mobile, password, avatarUrl, roleId, note, isActive, accessToken);
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Error checking existence: " + e);
        }
        return null;
    }

    public boolean changePassword(String pass, String account, String mode) {
        String sql = "UPDATE `swp391-spp`.`user`\n"
                + "SET\n"
                + "`password` = ?\n" // Removed quotes around the placeholder
                + "WHERE `" + mode + "` = ?"; // Removed quotes around placeholders and added mode directly to the query

        try {
            // Create a PreparedStatement
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            // Set the new password and account as parameters
            preparedStatement.setString(1, pass);
            preparedStatement.setString(2, account);

            // Execute the update
            int rowsAffected = preparedStatement.executeUpdate();
            System.out.println(pass + "  " + account + "  " + mode);
            System.out.println(sql);

            // Check if the update was successful
            if (rowsAffected > 0) {
                return true; // Password updated successfully
            } else {
                System.err.println("no records updated");
                return false; // No rows were updated (email not found)
            }
        } catch (SQLException e) {
            System.err.println(e);
            return false; // An error occurred
        }
    }

    public int insertUser(User us) {
        int n = 0;
        String sql = "INSERT INTO `swp391-spp`.`user`\n"
                //                + "(`avatar_url`,\n"
                + "(`full_name`,\n"
                + "`password`,\n"
                + "`email`,\n"
                + "`mobile`,\n"
                + "`role_id`,\n"
                + "`note`)\n"
                + "VALUES(?,?,?,?,?,?);";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
//            pre.setString(1, us.getAvatarUrl());
            pre.setString(1, us.getFullName());
            pre.setString(2, us.getPassword());
            pre.setString(3, us.getEmail());
            pre.setString(4, us.getMobile());
            pre.setInt(5, us.getRoleId());
            pre.setString(6, us.getNote());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public Vector getField(String id, String name) {
        Vector<String> vector = new Vector<String>();
        ResultSet rs = this.getData("select distinct " + id + "," + name + " from user join system_setting");
        try {
            while (rs.next()) {
                vector.add(rs.getString(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

//    public ResultSet getUser() {
//        String sql = "select * from user";
//        ResultSet rs = getData(sql);
//        return rs;
//    }
    public ResultSet getData(String sql) {
        ResultSet rs = null;
        try {
            Statement state = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs = state.executeQuery(sql);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return rs;
    }

    public Vector getUser(String sql) {
        Vector<User> vector = new Vector<User>();
        try {
            Statement state = connection.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                //dataType varName=rs.getDataType(fieldName|index);
                int uid = rs.getInt(1); // int pid=rs.getInt("productID");
                String name = rs.getString(2);//String pname=rs.getString(2);
                String email = rs.getString(3);
                String mobile = rs.getString(4);
                String pass = rs.getString(5);
                String avt = rs.getString(6);
                int role = rs.getInt(7);
                String note = rs.getString(8);
                int act = rs.getInt(13);
                String accessToken = rs.getString("access_token");
                User us = new User(uid, name, email, mobile, null, avt, role, note, act, accessToken);
                vector.add(us);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return vector;
    }

    public int updateUser(User us) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`user`\n"
                + "SET\n"
                + "`full_name` = ?,\n"
                //                + "`password` = ?,\n"
                + "`email` = ?,\n"
                + "`mobile` = ?,\n"
                + "`role_id` = ?,\n"
                + "`note` = ?\n"
                + "WHERE `user_id` = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, us.getFullName());
            pre.setString(2, us.getEmail());
            pre.setString(3, us.getMobile());
            pre.setInt(4, us.getRoleId());
            pre.setString(5, us.getNote());
            pre.setInt(6, us.getUserId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int UserStatusChange(int id, int status) {
        int result = 0;
        String sql = "UPDATE `swp391-spp`.`user`\n"
                + "SET\n"
                + "`is_active` = ?\n"
                + "WHERE `user_id` = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setInt(2, id);
            result = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public int getTotalAccount() {
        String sql = "select count(*) from user";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery(sql);
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalAccount1(String name) {
        String sql = "SELECT count(*) FROM User u INNER JOIN System_setting s ON u.role_id = s.setting_id WHERE u.full_name LIKE '%" + name + "%' or u.user_id like '" + name + "%' or s.setting_name like '%" + name + "%'";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery(sql);
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<User> pagingUser(int index) {
        List<User> list = new ArrayList<>();
        String sql = "select * from User limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 10);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(7),
                        rs.getInt(13)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Setting> getName() {
        List<Setting> list = new ArrayList<>();
        String sql = "select distinct setting_id, setting_group, setting_name, description from user inner join system_setting on role_id=setting_id";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Setting(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<User> searchName(int index, String name) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM User u WHERE u.full_name LIKE '%" + name + "%' or u.user_id like '" + name + "%' or u.email like '" + name + "%' limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 10);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(7),
                        rs.getInt(13)
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int updateProfile(User us) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`user`\n"
                + "SET\n"
                + "`avatar_url` =?,\n"
                + "`full_name` = ?,\n"
                //                + "`password` = ?,\n"
                + "`email` = ?,\n"
                + "`mobile` = ?,\n"
                + "`note` = ?\n"
                + "WHERE `user_id` = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, us.getAvatarUrl());
            pre.setString(2, us.getFullName());
            pre.setString(3, us.getEmail());
            pre.setString(4, us.getMobile());
            pre.setString(5, us.getNote());
            pre.setInt(6, us.getUserId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    public int updateProfile2(User us) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`user`\n"
                + "SET\n"      
                + "`full_name` = ?,\n"
                //                + "`password` = ?,\n"
                + "`email` = ?,\n"
                + "`mobile` = ?,\n"
                + "`note` = ?\n"
                + "WHERE `user_id` = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, us.getFullName());
            pre.setString(2, us.getEmail());
            pre.setString(3, us.getMobile());
            pre.setString(4, us.getNote());
            pre.setInt(5, us.getUserId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int changePass(User us) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`user` SET password =? WHERE `user_id` =?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, us.getPassword());
            pre.setInt(2, us.getUserId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public User getUserbyId(int id) {
        String sql = "select * from user where user_id = " + id + "";
        ResultSet rs = getData(sql);

        try {
            while (rs.next()) {
                int uid = rs.getInt(1);
                String password = rs.getString(5);
                User us = new User();
                us.setUserId(uid);
                us.setPassword(password);
                return us;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
   
}
