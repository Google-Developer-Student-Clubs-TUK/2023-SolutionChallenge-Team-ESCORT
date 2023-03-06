package com.solution.escort.domain.company.dto.request;

import com.solution.escort.domain.company.entity.Company;
import com.solution.escort.domain.protector.entity.Protector;
import lombok.*;
import lombok.extern.slf4j.Slf4j;

@AllArgsConstructor
@Builder
@Getter
@Setter
@Slf4j
@NoArgsConstructor
public class CompanyRequestDTO {
    private String address;
    private String title;
    private String description;
    private Protector protectorId;

    public Company toCompanyEntity(CompanyRequestDTO companyRequestDTO) {
        return Company.builder()
                .address(companyRequestDTO.address)
                .title(companyRequestDTO.title)
                .description(companyRequestDTO.description)
                .protector(companyRequestDTO.protectorId)
                .build();
    }
}
