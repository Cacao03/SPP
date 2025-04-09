/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Milestone;

/**
 *
 * @author Đàm Quang Chiến
 */
public class MilestoneDAO extends DBConnect {

    public List<Milestone> paginateClassMileStone(int index, int classId, int projectId) {

        List<Milestone> list = new ArrayList<>();
        String sql = "";
        if (projectId == 0) {
            sql = "select * from milestone where class_id = " + classId + "  and project_id is null limit 10 offset ? ";
        } else {
            sql = "select * from milestone where class_id = " + classId + "  and project_id =" + projectId + " union select * from milestone where class_id = "+classId+" and project_id is null limit 10 offset ? ";
        }

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 2);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Milestone mileStone = new Milestone();
                mileStone.setId(rs.getInt("milestone_id"));
                mileStone.setName(rs.getString("milestone_name"));
                mileStone.setDescript(rs.getString("description"));
                mileStone.setDueDate(rs.getDate("due_date"));
                mileStone.setIsActive(rs.getInt("is_active"));
                mileStone.setClassId(rs.getInt("class_id"));
                mileStone.setProjectId(rs.getInt("project_id"));
                mileStone.setStartDate(rs.getDate("start_date"));
                mileStone.setUpdateAt(rs.getTimestamp("updated_at"));
                list.add(mileStone);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Milestone> filterMilestone(int index, int classId, String type, int value) {

        List<Milestone> list = new ArrayList<>();
        String sql = "select * from milestone where class_id = " + classId + "  and project_id is null and " + type + " = ? limit 10 offset ? ";
        try ( PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, value);
            pre.setInt(2, (index - 1) * 10);

            try ( ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    Milestone mileStone = new Milestone();
                    mileStone.setId(rs.getInt("milestone_id"));
                    mileStone.setName(rs.getString("milestone_name"));
                    mileStone.setDescript(rs.getString("description"));
                    mileStone.setDueDate(rs.getDate("due_date"));
                    mileStone.setIsActive(rs.getInt("is_active"));
                    mileStone.setClassId(rs.getInt("class_id"));
                    mileStone.setProjectId(rs.getInt("project_id"));
                    mileStone.setStartDate(rs.getDate("start_date"));
                    mileStone.setUpdateAt(rs.getTimestamp("updated_at"));
                    list.add(mileStone);
                }
            }

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

    public List<Milestone> searchAndPaginateMilestone(int index, int classId, String searchValue) {

        List<Milestone> list = new ArrayList<>();
        String sql = "select * from milestone where class_id = " + classId + "  and project_id is null "
                + "AND (milestone.milestone_name LIKE ? OR milestone.due_date LIKE ? OR milestone.start_date LIKE ? OR milestone.is_active LIKE ?) "
                + "LIMIT 10 OFFSET ?";
        try ( PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, "%" + searchValue + "%");
            pre.setString(2, "%" + searchValue + "%");
            pre.setString(3, "%" + searchValue + "%");
            int status = -1;
            if (searchValue.toLowerCase().startsWith("active")) {
                status = 1;
            } else if (searchValue.toLowerCase().startsWith("inactive")) {
                status = 0;
            }
            pre.setInt(4, status);
            pre.setInt(5, (index - 1) * 10);

            try ( ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    Milestone mileStone = new Milestone();
                    mileStone.setId(rs.getInt("milestone_id"));
                    mileStone.setName(rs.getString("milestone_name"));
                    mileStone.setDescript(rs.getString("description"));
                    mileStone.setDueDate(rs.getDate("due_date"));
                    mileStone.setIsActive(rs.getInt("is_active"));
                    mileStone.setClassId(rs.getInt("class_id"));
                    mileStone.setProjectId(rs.getInt("project_id"));
                    mileStone.setStartDate(rs.getDate("start_date"));
                    mileStone.setUpdateAt(rs.getTimestamp("updated_at"));
                    list.add(mileStone);
                }
            }

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

    public List<Milestone> getListClassMilestone(int classId) {

        List<Milestone> list = new ArrayList<>();
        String sql = "select * from milestone where class_id = ? and project_id is null";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, classId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Milestone mileStone = new Milestone();
                mileStone.setId(rs.getInt("milestone_id"));
                mileStone.setName(rs.getString("milestone_name"));
                mileStone.setDescript(rs.getString("description"));
                mileStone.setDueDate(rs.getTimestamp("due_date"));
                mileStone.setIsActive(rs.getInt("is_active"));
                mileStone.setClassId(rs.getInt("class_id"));
                mileStone.setProjectId(rs.getInt("project_id"));
                mileStone.setStartDate(rs.getTimestamp("start_date"));
                mileStone.setUpdateAt(rs.getTimestamp("updated_at"));
                mileStone.setGitlabId(rs.getString("gitlab_id"));
                list.add(mileStone);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public List<Milestone> getListProjectMilestone(int projectId, int classId) {

        List<Milestone> list = new ArrayList<>();
        String sql = "select * from milestone where class_id = ? and project_id = ? ";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, classId);
            pre.setInt(2, projectId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Milestone mileStone = new Milestone();
                mileStone.setId(rs.getInt("milestone_id"));
                mileStone.setName(rs.getString("milestone_name"));
                mileStone.setDescript(rs.getString("description"));
                mileStone.setDueDate(rs.getTimestamp("due_date"));
                mileStone.setIsActive(rs.getInt("is_active"));
                mileStone.setClassId(rs.getInt("class_id"));
                mileStone.setProjectId(rs.getInt("project_id"));
                mileStone.setStartDate(rs.getTimestamp("start_date"));
                mileStone.setUpdateAt(rs.getTimestamp("updated_at"));
                mileStone.setGitlabId(rs.getString("gitlab_id"));
                list.add(mileStone);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Milestone getMilestoneById(int mileId) {

        String sql = "select * from milestone where milestone_id = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, mileId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Milestone mileStone = new Milestone();
                mileStone.setId(rs.getInt("milestone_id"));
                mileStone.setName(rs.getString("milestone_name"));
                mileStone.setDescript(rs.getString("description"));
                mileStone.setDueDate(rs.getDate("due_date"));
                mileStone.setIsActive(rs.getInt("is_active"));
                mileStone.setClassId(rs.getInt("class_id"));
                mileStone.setProjectId(rs.getInt("project_id"));
                mileStone.setStartDate(rs.getDate("start_date"));
                mileStone.setUpdateAt(rs.getTimestamp("updated_at"));
                return mileStone;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean checkExisted(String column, String value, int mileId, int classId) {
        String sql;
        if (mileId == 0) {
            sql = "SELECT * FROM milestone WHERE " + column + " = ? and class_id = ?";
        } else {
            sql = "SELECT * FROM milestone WHERE " + column + " = ? and milestone_id != ? and class_id = ?";
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, value);
            if (mileId != 0) {
                st.setInt(2, mileId); // Set the second parameter here
                st.setInt(3, classId);
            }else{
                st.setInt(2, classId);
            }
            ResultSet result = st.executeQuery();

            if (result.next()) {
                return true; // If there is at least one matching record, return true
            }
        } catch (SQLException e) {
            System.out.println("Error checking existence: " + e);
        }

        return false; // No matching records found
    }

    public boolean updateMilestone(Milestone milestone) {
        String sql = "UPDATE `swp391-spp`.`milestone`\n"
                + "SET `milestone_name` = ?, `description` = ?, `due_date` = ?, `start_date` = ?, updated_at =?, is_active = ? WHERE `milestone_id` =?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, milestone.getName());
            st.setString(2, milestone.getDescript());

            // Check if milestone.getDueDate() is not null before converting to java.sql.Date
            String dueDateString = milestone.getDueDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(milestone.getDueDate()) : null;
            st.setString(3, dueDateString);

            // Check if milestone.getStartDate() is not null before formatting
            String startDateString = milestone.getStartDate() != null ? new SimpleDateFormat("yyyy-MM-dd").format(milestone.getStartDate()) : null;
            st.setString(4, startDateString);
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            st.setTimestamp(5, currentTimestamp);
            st.setInt(6, milestone.getIsActive());
            st.setInt(7, milestone.getId());

            boolean result = st.executeUpdate() == 1;
            if (result) {
                return true;
            }

        } catch (SQLException e) {
            System.out.println("Error update existence: " + e);
        }

        return false; // No matching records found
    }

    public boolean updateGitlabMilestone(String title, String gitId) {
        String sql = "UPDATE `swp391-spp`.`milestone`\n"
                + "SET  `gitlab_id` = ? WHERE `milestone_name` =?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, gitId);
            st.setString(2, title);

            boolean result = st.executeUpdate() == 1;
            if (result) {
                return true;
            }

        } catch (SQLException e) {
            System.out.println("Error update existence: " + e);
        }

        return false; // No matching records found
    }

    public int getTotalClassMileStones(int classID) {
        String sql = "SELECT COUNT(*) FROM milestone WHERE class_id = ? AND project_id IS NULL";

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

    public boolean changeMilestoneStatus(int mileId, int status) {
        String sql = "UPDATE `swp391-spp`.`milestone` SET `is_active` = ?, updated_at =? WHERE `milestone_id` = ?";
        boolean check = true;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, status);
            Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
            pre.setTimestamp(2, currentTimestamp);
            pre.setInt(3, mileId);
            check = pre.executeUpdate() == 1;

        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }

    public boolean insertMilestone(Milestone milestone) {
        String sql = "INSERT INTO `swp391-spp`.`milestone` "
                + "(`milestone_name`, `description`, `due_date`, "
                + "`is_active`, `class_id`, `created_by`, `created_at`, `start_date`, `gitlab_id`) "
                + "VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?)";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, milestone.getName());
            st.setString(2, milestone.getDescript());
            st.setDate(3, milestone.getDueDate() != null ? new java.sql.Date(milestone.getDueDate().getTime()) : null);
            st.setInt(4, milestone.getIsActive());
            st.setInt(5, milestone.getClassId());
            st.setInt(6, 1);
            st.setDate(7, milestone.getStartDate() != null ? new java.sql.Date(milestone.getStartDate().getTime()) : null);
            st.setString(8, milestone.getGitlabId());
            int rowsAffected = st.executeUpdate();

            return rowsAffected == 1;
        } catch (SQLException e) {
            return false; // Handle the exception gracefully and return false on error.
        }
    }
    
    public boolean insertProjectMilestone(Milestone milestone) {
        String sql = "INSERT INTO `swp391-spp`.`milestone` "
                + "(`milestone_name`, `description`, `due_date`, "
                + "`is_active`, `class_id`, `created_by`, `created_at`, `start_date`, `gitlab_id`, `project_id`) "
                + "VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?, ?)";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, milestone.getName());
            st.setString(2, milestone.getDescript());
            st.setDate(3, milestone.getDueDate() != null ? new java.sql.Date(milestone.getDueDate().getTime()) : null);
            st.setInt(4, milestone.getIsActive());
            st.setInt(5, milestone.getClassId());
            st.setInt(6, 1);
            st.setDate(7, milestone.getStartDate() != null ? new java.sql.Date(milestone.getStartDate().getTime()) : null);
            st.setString(8, milestone.getGitlabId());
            st.setInt(9, milestone.getProjectId());
            int rowsAffected = st.executeUpdate();

            return rowsAffected == 1;
        } catch (SQLException e) {
            return false; // Handle the exception gracefully and return false on error.
        }
    }
    
    public boolean deleteMilestone(int id){
        String sql = "delete from `swp391-spp`.milestone where milestone_id =?";
         try ( PreparedStatement st = connection.prepareStatement(sql)) {
             st.setInt(1, id);
             int result = st.executeUpdate();
             return result ==1;
         }catch (SQLException e) {
            return false; // Handle the exception gracefully and return false on error.
        }
    }

    public static void main(String[] args) {
        MilestoneDAO dao = new MilestoneDAO();
        Milestone mi = dao.getMilestoneById(16);
        System.out.println(mi);
    }

}
