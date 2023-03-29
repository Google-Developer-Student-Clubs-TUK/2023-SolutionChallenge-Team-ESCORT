package com.solution.escort.domain.logging.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.solution.escort.domain.protector.entity.Protector;
import com.solution.escort.domain.protege.entity.Protege;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.DynamicInsert;
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
@EntityListeners(AuditingEntityListener.class)
@Slf4j
public class Logging {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id; // 신고 등록 service에서 가능

    @ManyToOne
    @JoinColumn(name = "protector_id")
    @JsonIgnore
    private Protector protector; //

    private String ProtectorName;

    private String ProtectorFbId;


    @ManyToOne
    @JoinColumn(name = "protege_id")
    @JsonIgnore
    private Protege protege; // 신고 등록 service에서 가능

    private String ProtegeName;

    private String ProtegeFbId;


    @Column
    private LocalDateTime reportTime; // 신고 등록 service에서 가능


    @Column
    private LocalDateTime reportCancelTime; // 신고 취소 service에서 가능

    // 위도, 경도 필요?? 생각해보고 필요할 것 같으면 넣을 예정

    @Column
    private LocalDateTime safeTime; // firebase에서 들고와야함 or 프론트에서 api request 날려주기?

    @Column
    private LocalDateTime dangerousTime; // firebase에서 들고와야함 or 프론트에서 api request 날려주기?
}
