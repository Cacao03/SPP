/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import enums.SettingGroup;
import enums.UserRole;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ClassStudent;

/**
 *
 * @author Đàm Quang Chiến
 */
public class ClassStudentDAO extends DBConnect {

    public List<ClassStudent> paginateClassStudent(int index, int classId, String sortType, String sortVal, String sortVal2) {

        List<ClassStudent> list = new ArrayList<>();

        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("SELECT * FROM `swp391-spp`.class_student ")
                .append("left join project on class_student.project_id = project.project_id ")
                .append("join user on class_student.student_id = user.user_id ")
                .append("where class_student.class_id = ? ");

        if (sortType != null) {
            if (sortVal != null) {
                sqlBuilder.append("and class_student.project_id = ? ");
            }
            if (sortVal2 != null) {
                sqlBuilder.append("and class_student.is_active = ? ");
            }
        }

        sqlBuilder.append("limit 10 offset ? ");

        String sql = sqlBuilder.toString();

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, classId);
            int indexCounter = 2;

            if (sortType != null) {
                if (sortVal != null) {
                    pre.setString(indexCounter++, sortVal);
                }
                if (sortVal2 != null) {
                    pre.setString(indexCounter++, sortVal2);
                }
            }
            pre.setInt(indexCounter, (index - 1) * 10);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                ClassStudent classSt = new ClassStudent();
                classSt.setId(rs.getInt("class_st_id"));
                classSt.setClassId(rs.getInt("class_id"));
                classSt.setGroupId(rs.getInt("project_id"));
                classSt.setStudentId(rs.getInt("student_id"));
                classSt.setIsActive(rs.getInt("is_active"));
                classSt.setNote(rs.getString("note"));
                classSt.setGroupName(rs.getString("project_code"));
                classSt.setStudentName(rs.getString("full_name"));
                list.add(classSt);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<ClassStudent> searchAndPaginateStudent(int index, int classId, String searchValue) {

        List<ClassStudent> list = new ArrayList<>();
        String sql = "SELECT * FROM `swp391-spp`.class_student"
                + " left join project on class_student.project_id = project.project_id join user on class_student.student_id = user.user_id"
                + " where class_student.class_id = " + classId
                + " AND (project.project_code LIKE ? OR user.full_name LIKE ? OR class_student.is_active LIKE ?) "
                + " LIMIT 10 OFFSET ?";
        try ( PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, "%" + searchValue + "%");
            pre.setString(2, "%" + searchValue + "%");
            int status = -1;
            if (searchValue.toLowerCase().startsWith("active")) {
                status = 1;
            } else if (searchValue.toLowerCase().startsWith("inactive")) {
                status = 0;
            }
            pre.setInt(3, status);
            pre.setInt(4, (index - 1) * 10);

            try ( ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    ClassStudent classSt = new ClassStudent();
                    classSt.setId(rs.getInt("class_st_id"));
                    classSt.setClassId(rs.getInt("class_id"));
                    classSt.setGroupId(rs.getInt("project_id"));
                    classSt.setStudentId(rs.getInt("student_id"));
                    classSt.setIsActive(rs.getInt("is_active"));
                    classSt.setNote(rs.getString("note"));
                    classSt.setGroupName(rs.getString("project_code"));
                    classSt.setStudentName(rs.getString("full_name"));
                    list.add(classSt);
                }
            }

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

    public List<ClassStudent> getListClassStudent(int classId) {

        List<ClassStudent> list = new ArrayList<>();

        String sql = "SELECT * FROM `swp391-spp`.class_student left join project on class_student.project_id = project.project_id join "
                + "user on class_student.student_id = user.user_id join `swp391-spp`.class on class_student.class_id = class.class_id where class_student.class_id = ? ";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, classId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                ClassStudent classSt = new ClassStudent();
                classSt.setId(rs.getInt("class_st_id"));
                classSt.setClassId(rs.getInt("class_id"));
                classSt.setClassName(rs.getString("class_code"));
                classSt.setGroupId(rs.getInt("project_id"));
                classSt.setStudentId(rs.getInt("student_id"));
                classSt.setIsActive(rs.getInt("is_active"));
                classSt.setNote(rs.getString("note"));
                classSt.setGroupName(rs.getString("group_name"));
                classSt.setProjectCode(rs.getString("project_code"));
                classSt.setStudentName(rs.getString("full_name"));
                list.add(classSt);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalClasStudent(int classID, String sortType, String sortVal, String sortVal2) {
        String sql = "";
        if (sortType == null || sortType.isEmpty()) {
            sql = "SELECT COUNT(*) FROM class_student WHERE class_id = ?";
        } else if (sortType.equals("project")) {
            sql = "SELECT COUNT(*) FROM class_student WHERE class_id = ? and project_id = " + sortVal;
        } else {
            sql = "SELECT COUNT(*) FROM class_student WHERE class_id = ? and is_active = " + sortVal2;
        }

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, classID);
            ResultSet rs = pre.executeQuery(); // Corrected line
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public boolean changeClassStStatus(int classStId, int status) {
        String sql = "UPDATE `swp391-spp`.`class_student` SET `is_active` = ?, updated_at =? WHERE `class_st_id` = ?";
        boolean check = true;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, status);
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            pre.setTimestamp(2, currentTimestamp);
            pre.setInt(3, classStId);
            check = pre.executeUpdate() == 1;

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }

    public boolean updateClassSt(int classStId, int status, String des) {
        String sql = "UPDATE `swp391-spp`.`class_student` SET `is_active` = ?, `note` = ?, updated_at =? WHERE `class_st_id` = ?";
        boolean check = true;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setString(2, des);
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            pre.setTimestamp(3, currentTimestamp);
            pre.setInt(4, classStId);
            check = pre.executeUpdate() == 1;

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }

    public void createNewClassSt(ClassStudent classSt) throws SQLException {
        String sql;
        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

        if (classSt.getGroupId() == 0) {
            // If groupId is 0, we won't insert the group_id field
            sql = "INSERT INTO class_student (`class_id`, `student_id`, `is_active`, `note`, `created_at`) VALUES (?, ?, ?, ?, ?)";

            try ( PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, classSt.getClassId());
                statement.setInt(2, classSt.getStudentId());
                statement.setInt(3, classSt.getIsActive());
                statement.setString(4, classSt.getNote());
                statement.setTimestamp(5, currentTimestamp);

                statement.executeUpdate();
            }

        } else {
            sql = "INSERT INTO class_student (`class_id`, `student_id`, `project_id`, `is_active`, `note`, `created_at`) VALUES (?, ?, ?, ?, ?, ?)";

            try ( PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, classSt.getClassId());
                statement.setInt(2, classSt.getStudentId());
                statement.setInt(3, classSt.getGroupId());
                statement.setInt(4, 1);
                statement.setString(5, classSt.getNote());
                statement.setTimestamp(6, currentTimestamp);

                statement.executeUpdate();
            }
        }
    }

    public ClassStudent getClassStById(int id, int projectId) {
        String sql = "";
        if (projectId != 0) {
            sql = "SELECT * FROM `swp391-spp`.class_student join project on class_student.project_id = project.project_id join user on class_student.student_id = user.user_id where class_student.class_st_id = ? ";
        } else {
            sql = "SELECT * FROM `swp391-spp`.class_student join user on class_student.student_id = user.user_id where class_student.class_st_id = ? ";
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                ClassStudent classSt = new ClassStudent();
                classSt.setId(rs.getInt("class_st_id"));
                classSt.setClassId(rs.getInt("class_id"));
                classSt.setGroupId(rs.getInt("project_id"));
                classSt.setStudentId(rs.getInt("student_id"));
                classSt.setIsActive(rs.getInt("is_active"));
                classSt.setNote(rs.getString("note"));
                if (projectId != 0) {
                    classSt.setGroupName(rs.getString("project_code"));
                }
                classSt.setStudentName(rs.getString("full_name"));
                return classSt;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean checkClassGroupProjectExist(int classId, int projectId, int userId) {

        boolean isClassExist = new ClassDAO().checkClassExisted(classId);
        boolean isStudentExist = new UserDAO().checkStudentExisted(userId);
        boolean isProjectexist = new ProjectDAO().checkProjectExisted(projectId);
        if (!isClassExist || !isStudentExist || !isProjectexist) {
            return false;
        }
        return true;
    }

    public boolean checkDuplicate(int classId, int projectId, int userId) {
        String sql = "SELECT COUNT(*) FROM class_student "
                + "WHERE class_id = ? AND project_id = ? AND student_id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, classId);
            pre.setInt(2, projectId);
            pre.setInt(3, userId);

            try ( ResultSet resultSet = pre.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 1; // If count is greater than 1, duplicates exist
                }
            }
            return false;

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

//    public static void main(String[] args) {
//        ClassStudentDAO dao = new ClassStudentDAO();
//        List<ClassStudent> list = dao.paginateClassStudent(1, 1, "project", );
//    }
}
