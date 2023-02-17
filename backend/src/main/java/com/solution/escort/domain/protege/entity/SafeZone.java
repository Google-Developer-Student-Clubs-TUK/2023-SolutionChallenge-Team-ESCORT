package com.solution.escort.domain.protege.entity;

import com.solution.escort.domain.protege.entity.Protege;
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
@NoArgsConstructor
@DynamicInsert
@ToString
@EntityListeners(AuditingEntityListener.class)
@Slf4j
public class SafeZone {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String safeAddress;

    @Column
    @CreatedDate
    private LocalDateTime createdAt;

    // 노인(Protege)과 SafeZone은 다대일 관계
    @ManyToOne
    @JoinColumn(name = "protege_id")
    private Protege protege;

}
