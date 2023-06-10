package com.solution.escort.domain.langdingpage.entity;


import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;


@Entity
@Getter @Setter
@EntityListeners(LandingPageUser.LandingPageUserlListener.class)
public class LandingPageUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;
    private String message;
    private LocalDateTime createdAt;


    public static class LandingPageUserlListener {
        @PrePersist
        public void setTimestamps(LandingPageUser landingPageUser) {
            LocalDateTime now = LocalDateTime.now();
            landingPageUser.setCreatedAt(now);
        }
    }



}
