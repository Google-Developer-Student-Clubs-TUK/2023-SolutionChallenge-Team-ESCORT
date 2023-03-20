package com.solution.escort.domain.PPConnection.dto.request;

import com.solution.escort.domain.PPConnection.entity.ProtectorProtege;
import com.solution.escort.domain.protector.entity.Protector;
import com.solution.escort.domain.protege.entity.Protege;
import lombok.*;
import lombok.extern.slf4j.Slf4j;

@AllArgsConstructor
@Builder
@Getter
@Setter
@Slf4j
@NoArgsConstructor
public class PPConnectionRequestDTO {
    private String protectorUId;

    private String protegeUId;

}
