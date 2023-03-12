package com.solution.escort.domain.company.entity;

import com.solution.escort.domain.company.dto.request.CompanyRequestDTO;
import com.solution.escort.domain.company.dto.response.CompanyResponseDTO;
import com.solution.escort.domain.company.repository.CompanyRepository;
import com.solution.escort.domain.protector.entity.Protector;
import lombok.*;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.*;
import javax.sound.sampled.AudioFileFormat;
import java.net.URL;
import java.util.List;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AudioFileFormat.class)
@Slf4j
public class Company {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String address;

    @Column
    private String title;

    @Column
    private String description;

    // url 추후 추가 예정
    @ManyToOne
    @JoinColumn(name = "protector_id")
    private Protector protector;

    public CompanyResponseDTO toCompanyResponseDTO (Company company, List<URL> images) {
        return CompanyResponseDTO.builder()
                .id(company.getId())
                .address(company.getAddress())
                .title(company.getTitle())
                .description(company.getDescription())
                .protector(company.protector)
                .images(images)
                .build();
    }

    public CompanyResponseDTO toCompanyListResponseDTO (Company company, List<URL> images) {
        return CompanyResponseDTO.builder()
                .id(company.getId())
                .address(company.getAddress())
                .title(company.getTitle())
                .description(company.getDescription())
                .protector(company.protector)
                .images(images)
                .build();
    }


}
