package com.solution.escort.domain.protege.entity;

import com.solution.escort.domain.protege.dto.response.ProtegeResponseDTO;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@DynamicInsert
@ToString
@EntityListeners(AuditingEntityListener.class)
@Slf4j
public class Protege {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String name;

    @Column
    private String email;

    @Column
    private String password;

//    @Column
//    private String profileImageUrl;

    @Column
    private String characteristic;

    @Column
    private String bloodType;

    @Column
    private String address;

    @Column
    private String phone;

    @Column
    private String clothing;

    @Column
    @CreatedDate
    private LocalDateTime createdAt;

//    @OneToOne(fetch = FetchType.LAZY) // 프로필사진 1:1 매핑
//    @JoinColumn(name = "profileImage_id")
//    private ProfileImage profileImageId;

    public ProtegeResponseDTO toProtegeResponseDTO(Protege protege, List<String> safeZones) {
        return ProtegeResponseDTO.builder()
                .id(protege.getId())
                .email(protege.getEmail())
//                .password(protege.getPassword())
                .name(protege.getName())
                .characteristic(protege.getCharacteristic())
                .bloodType(protege.getBloodType())
                .phone(protege.getPhone())
                .address(protege.getAddress())
                .safeZones(safeZones)
                .build();
    }
}
