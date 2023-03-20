package com.solution.escort.domain.protege.dto.response;

import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@Data
@NoArgsConstructor
@Builder
public class SafeZoneResponseDTO {
    private String SafeAddress;

    private List safeZones;

}
