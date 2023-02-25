package com.solution.escort.domain.sos.dto.response;

import com.solution.escort.domain.protege.entity.Protege;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class SOSResponseDTO {
    private Integer id;
    private Protege protege;

}
