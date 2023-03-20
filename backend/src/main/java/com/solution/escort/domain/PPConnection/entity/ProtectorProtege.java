package com.solution.escort.domain.PPConnection.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.solution.escort.domain.protector.entity.Protector;
import com.solution.escort.domain.protege.entity.Protege;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

// 다대다 위해 엔티티로 승격
@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@DynamicInsert
@EntityListeners(AuditingEntityListener.class)
@Slf4j
public class ProtectorProtege {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "protector_id")
    @JsonIgnore
    private Protector protector;

    @ManyToOne
    @JoinColumn(name = "protege_id")
    @JsonIgnore
    private Protege protege;


}
