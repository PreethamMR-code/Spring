package com.nexmeet.platform.entity;

/*
 * @Entity tells Hibernate: "This Java class maps to a database table."
 * Without this annotation, Hibernate completely ignores this class.
 *
 * @Table(name = "roles") tells Hibernate: "The table name is 'roles'."
 * If your class name matched the table name exactly (case-insensitive),
 * you could skip @Table — but it's best practice to always be explicit.
 */

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


@Getter
@Setter
@NoArgsConstructor
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


    @Override
    public String toString(){
        return "Role{id=" + id + ", name='" + name + "'}";
    }

}
