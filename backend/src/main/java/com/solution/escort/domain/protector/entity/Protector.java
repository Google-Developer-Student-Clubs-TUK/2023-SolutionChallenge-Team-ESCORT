package com.solution.escort.domain.protector.entity;

import com.solution.escort.domain.PPConnection.dto.response.PgeResponseDTO;
import com.solution.escort.domain.PPConnection.dto.response.PtorResponseDTO;
import com.solution.escort.domain.PPConnection.entity.ProtectorProtege;
import com.solution.escort.domain.protector.dto.response.ProtectorResponseDTO;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@DynamicInsert
@EntityListeners(AuditingEntityListener.class)
@Slf4j
public class Protector {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String phone;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private String deviceToken;

    @ColumnDefault("82")
    private String countryCode;

    @Column
    private String imageUrl;

    @Column(nullable = false)
    private String fbId;

    @Column(nullable = false)
    private String birth;


    @OneToMany(mappedBy = "protector")
    private List<ProtectorProtege> proteges = new ArrayList<>();

    public ProtectorResponseDTO toProtectorResponseDTO(Protector protector) {
        return ProtectorResponseDTO.builder()
                .id(protector.getId())
                .email(protector.getEmail())
                .name(protector.getName())
                .phone(protector.getPhone())
                .address(protector.getAddress())
                .deviceToken(protector.getDeviceToken())
                .countryCode(protector.getCountryCode())
                .imageUrl(protector.getImageUrl())
                .uId(protector.getFbId())
                .birth(protector.getBirth())
                .build();

    }

    // uid 추가 필요할수도
    public PtorResponseDTO toPtorResponseDTO(Protector protector) {
        return PtorResponseDTO.builder()
                .id(protector.getId())
                .name(protector.getName())
                .phone(protector.getPhone())
                .imageUrl(protector.getImageUrl())
                .build();
    }
}
