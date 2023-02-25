package com.solution.escort.domain.sos.entity;

import com.solution.escort.domain.protege.entity.Protege;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@DynamicInsert
@EntityListeners(AuditingEntityListener.class)
@Slf4j
public class SOS {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "protege_id")
    private Protege protege;
}
