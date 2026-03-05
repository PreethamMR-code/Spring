package com.nexmeet.platform.entity;

/*
 * @Entity tells Hibernate: "This Java class maps to a database table."
 * Without this annotation, Hibernate completely ignores this class.
 *
 * @Table(name = "roles") tells Hibernate: "The table name is 'roles'."
 * If your class name matched the table name exactly (case-insensitive),
 * you could skip @Table — but it's best practice to always be explicit.
 */

import javax.persistence.*;

@Entity
@Table(name = "roles")
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "name", nullable = false, unique = true, length = 50)
    private String name;

    @Column(name = "description", length = 200)
    private String description;



    public Role(){

    }

    public Integer getId(){
        return id;
    }
    public void setId(Integer id){
        this.id = id;
    }

    public String getName(){
        return name;
    }
    public void setName(String name){
        this.name = name;
    }

    public String getDescription(){
        return description;
    }
    public void setDescription(String description){
        this.description = description;
    }

    @Override
    public String toString(){
        return "Role{id=" + id + ", name='" + name + "'}";
    }

}
