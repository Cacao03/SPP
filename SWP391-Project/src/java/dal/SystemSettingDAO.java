/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Setting;

/**
 *
 * @author TRAN DUNG
 */
public class SystemSettingDAO extends DBConnect {

    public List<Setting> pagingSettingByStatus(String status, int index) {
        List<Setting> list = new ArrayList<>();
        String sql = "select * from system_setting where is_active = ? limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(2, (index - 1) * 10);
            pre.setString(1, status);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Setting(
                        rs.getInt("setting_id"),
                        rs.getString("setting_group"),
                        rs.getString("setting_name"),
                        rs.getInt("display_order"),
                        rs.getString("description"),
                        rs.getInt("is_active")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Setting> pagingSettingByGroup(String group, int index) {
        List<Setting> list = new ArrayList<>();
        String sql = "select * from system_setting where setting_group = ? limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(2, (index - 1) * 10);
            pre.setString(1, group);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Setting(
                        rs.getInt("setting_id"),
                        rs.getString("setting_group"),
                        rs.getString("setting_name"),
                        rs.getInt("display_order"),
                        rs.getString("description"),
                        rs.getInt("is_active")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Setting> pagingSetting(int index) {
        List<Setting> list = new ArrayList<>();
        String sql = "select * from system_setting limit 10 offset ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 10);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Setting(
                        rs.getInt("setting_id"),
                        rs.getString("setting_group"),
                        rs.getString("setting_name"),
                        rs.getInt("display_order"),
                        rs.getString("description"),
                        rs.getInt("is_active")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalSystemSetting() {
        String sql = "select count(*) from system_setting ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery(sql);
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Setting> getListSetting() {
        List<Setting> list = new ArrayList<>();
        String sql = "select * from system_setting";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int setting_id = rs.getInt(1);
                String settingGroup = rs.getString(2);
                String settingName = rs.getString(3);
                int displayOrder = rs.getInt(4);
                String description = rs.getString(5);
                int isActive = rs.getInt(6);

                Setting setting = new Setting(setting_id, settingGroup, settingName, displayOrder, description, isActive);
                list.add(setting);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ResultSet getSettingbyID1(String setting_id) {
        ResultSet rs = null;
        String sql = "select * from system_setting where setting_id=" + setting_id;
        rs = getData(sql);
        return rs;
    }

    public ResultSet findSystemSettingbyGroup(String Setting_Group) {
        ResultSet rs = null;
        String sql = "SELECT * FROM `swp391-spp`.system_setting where setting_group like " + Setting_Group + "";
        rs = getData(sql);
        return rs;
    }

    public boolean checkDuplicate(String Setting_Name) {
        String query = "SELECT setting_name FROM `swp391-spp`.system_setting where setting_name = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, Setting_Name);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ResultSet getSettingName() {
        ResultSet rs = null;
        String sql = "SELECT setting_name FROM `swp391-spp`.system_setting";

        rs = getData(sql);
        return rs;
    }

    public List<Setting> getListGroupSetting(int group) {
        List<Setting> list = new ArrayList<>();
        String sql = "select * from system_setting where setting_group = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, group);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int setting_id = rs.getInt(1);
                String settingGroup = rs.getString(2);
                String settingName = rs.getString(3);
                int displayOrder = rs.getInt(4);
                String description = rs.getString(5);
                int isActive = rs.getInt(6);
                Setting setting = new Setting(setting_id, settingGroup, settingName, displayOrder, description, isActive);
                list.add(setting);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public ResultSet getRsSetting() {
        String sql = "select * from system_setting";
        ResultSet rs = getData(sql);
        return rs;
    }

    public Setting getSettingbyID(int id) {
        String sql = "select * from system_setting where setting_id = " + id + "";
        ResultSet rs = getData(sql);

        try {
            while (rs.next()) {
                int settingId = rs.getInt(1);
                String settingGroup = rs.getString(2);
                String settingName = rs.getString(3);
                String description = rs.getString(5);
                Setting setting = new Setting(settingId, settingGroup, settingName, description);
                return setting;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int updateSystemSetting(Setting setting) {
        int n = 0;
        String sql = "UPDATE `swp391-spp`.`system_setting`\n"
                + "SET\n"
                + "`setting_group` = ?,\n"
                + "`setting_name` = ?,\n"
                + "`description` = ?\n"
                + "WHERE `setting_id` = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, setting.getSettingGroup());
            pre.setString(2, setting.getSettingName());
            pre.setString(3, setting.getDescription());
            pre.setInt(4, setting.getSettingId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int addSystemSetting(Setting setting) {
        int n = 0;
        String sql = "INSERT INTO `swp391-spp`.`system_setting`\n"
                + "(`setting_group`,\n"
                + "`setting_name`,\n"
                + "`description`)\n"
                + "VALUES\n"
                + "(?,?,?);";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, setting.getSettingGroup());
            pre.setString(2, setting.getSettingName());
            pre.setString(3, setting.getDescription());

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return n;
    }

    public int changeStatusbyID(int id, int status) {
        int result = 0;
        String sql = "UPDATE `swp391-spp`.`system_setting`\n"
                + "SET\n"
                + "`is_active` = ?\n"
                + "WHERE `setting_id` = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, status);
            pre.setInt(2, id);

            result = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public boolean checkDomainExist(String domain) {
        String sql = "SELECT * FROM `swp391-spp`.`system_setting` WHERE setting_name = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, domain);
            ResultSet result = st.executeQuery();

            if (result.next()) {
                return true; // If there is at least one matching record, return true
            }
        } catch (SQLException e) {
            System.out.println("Error checking existence: " + e);
        }

        return false; // No matching records found
    }

    public int checkSettingActive(int id) {
        String sql = "select * from system_setting where setting_id = " + id + "";
        ResultSet rs = getData(sql);
        int isActive = 0;
        try {
            while (rs.next()) {
                isActive = rs.getInt("is_active");
                return isActive;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SystemSettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return isActive;
    }

    public static void main(String[] args) throws SQLException {
        SystemSettingDAO dao = new SystemSettingDAO();

        List<Setting> list = dao.pagingSettingByGroup("1", 1);

        System.out.println(list);
    }
}
