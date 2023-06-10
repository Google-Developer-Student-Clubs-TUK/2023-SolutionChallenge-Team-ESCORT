package com.solution.escort.domain.langdingpage.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;



@Entity
@Getter
@Setter
@EntityListeners(LandingPageCompany.LandingPageCompanyListener.class)
public class LandingPageCompany {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String managerName;
    private String email;
    private String companyName;
    private String message;
    private LocalDateTime createdAt;


    public static class LandingPageCompanyListener {
        @PrePersist
        public void setTimestamps(LandingPageCompany landingPageCompany) {
            LocalDateTime now = LocalDateTime.now();
            landingPageCompany.setCreatedAt(now);

        }
    }

}
