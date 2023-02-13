package com.solution.escort.domain.protege.entity;

import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@DynamicInsert
@ToString
@EntityListeners(AuditingEntityListener.class)
@Slf4j
public class Protege {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String name;

    @Column
    private String email;

    @Column
    private String password;

    @Column
    private String profileImageUrl;

    @Column
    private String characteristic;

    @Column
    private String bloodType;

    @Column
    private String address;

    @Column
    private String phone;

    @Column
    private String clothing;

    @Column
    @CreatedDate
    private LocalDateTime createdAt;

    public Protege() {

    }
}
