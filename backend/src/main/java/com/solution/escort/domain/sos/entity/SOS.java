package com.solution.escort.domain.sos.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.domain.sos.dto.response.SOSResponseDTO;
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
    @JsonIgnore
    private Protege protege;

    public SOSResponseDTO toSOSResponse(SOS sos) {
        return SOSResponseDTO.builder()
                .id(sos.getId())
                .protege(sos.getProtege())
                .build();
    }
}
