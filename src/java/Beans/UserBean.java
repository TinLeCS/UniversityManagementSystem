/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

/**
 *
 * @author Leader
 */
public class UserBean {
    private String ID;
    private String pass;
    private String name;
    private String sex;
    private String add;
    private String mail;
    private String phone;
    private String school;
    
    public void setName(String name){
        this.name = name;
    }
    public String getName(){
        return name;
    }
    
    public void setPassword(String pass){
        this.pass = pass;
    }
    public String getPassword(){
        return pass;
    }
    
    public void setID(String ID){
        this.ID = ID;
    }
    public String getID(){
        return ID;
    }
    
    public void setSex(String sex){
        this.sex = sex;
    }
    public String getSex(){
        return sex;
    }
    
    public void setAdress(String add){
        this.add = add;
    }
    public String getAddress(){
        return add;
    }
    
    public void setMail(String mail){
        this.mail = mail;
    }
    public String getMail(){
        return mail;
    }
    
    public void setPhone(String phone){
        this.phone = phone;
    }
    public String getPhone(){
        return phone;
    }
    
    public void setSchool(String school){
        this.school = school;
    }
    public String getSchool(){
        return school;
    }
}
