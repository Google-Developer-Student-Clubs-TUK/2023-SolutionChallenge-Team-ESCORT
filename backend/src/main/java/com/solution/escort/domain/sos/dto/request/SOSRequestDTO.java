package com.solution.escort.domain.sos.dto.request;

import com.solution.escort.domain.PPConnection.dto.request.PPConnectionRequestDTO;
import com.solution.escort.domain.PPConnection.entity.ProtectorProtege;
import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.domain.sos.entity.SOS;
import lombok.*;
import lombok.extern.slf4j.Slf4j;

@AllArgsConstructor
@Builder
@Getter
@Setter
@Slf4j
@NoArgsConstructor
public class SOSRequestDTO {
    private Protege protegeId;

    public SOS toSOSEntity(SOSRequestDTO sosRequestDTO) {
        return SOS.builder()
                .protege((sosRequestDTO.protegeId))
                .build();
    }
}
