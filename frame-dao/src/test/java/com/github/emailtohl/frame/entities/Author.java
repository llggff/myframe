package com.github.emailtohl.frame.entities;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name = "Authors", indexes = {
        @Index(name = "Authors_Names", columnList = "AuthorName")
})
public class Author implements Serializable
{
	private static final long serialVersionUID = -2410035755411678068L;
	private long id;
    private String name;
    private String emailAddress;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AuthorId")
    public long getId()
    {
        return this.id;
    }

    public void setId(long id)
    {
        this.id = id;
    }

    @Basic
    @Column(name = "AuthorName")
    public String getName()
    {
        return this.name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    @Basic
    public String getEmailAddress()
    {
        return this.emailAddress;
    }

    public void setEmailAddress(String emailAddress)
    {
        this.emailAddress = emailAddress;
    }
}
