package com.solution.escort.domain.company.dto.response;

import com.solution.escort.domain.protector.entity.Protector;
import lombok.*;
import lombok.extern.slf4j.Slf4j;

@AllArgsConstructor
@Builder
@Getter
@ToString
@Setter
@Slf4j
@NoArgsConstructor
public class CompanyResponseDTO {
    private Integer id;
    private String title;
    private String address;
    private String description;
    private Protector protector;
}
