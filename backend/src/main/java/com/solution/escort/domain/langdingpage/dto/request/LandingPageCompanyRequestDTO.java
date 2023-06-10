package com.solution.escort.domain.langdingpage.dto.request;

import com.solution.escort.domain.langdingpage.entity.LandingPageCompany;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor
public class LandingPageCompanyRequestDTO {
    @NotEmpty(message = "이름은 필수 입력 값입니다.")
    private String managerName;
    @NotEmpty(message = "이메일은 필수 입력 값입니다.")
    @Email(message = "이메일 형식에 맞지 않습니다.")
    private String email;
    @NotEmpty(message = "회사 이름은 필수 입력 값입니다.")
    private String companyName;
    private String message;

    public LandingPageCompanyRequestDTO(LandingPageCompany landingPageCompany) {
        this.managerName = landingPageCompany.getManagerName();
        this.email = landingPageCompany.getEmail();
        this.companyName = landingPageCompany.getCompanyName();
        this.message = landingPageCompany.getMessage();
    }
}
