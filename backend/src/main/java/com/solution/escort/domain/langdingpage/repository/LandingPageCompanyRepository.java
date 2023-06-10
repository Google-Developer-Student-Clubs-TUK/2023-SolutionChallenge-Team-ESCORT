package com.solution.escort.domain.langdingpage.repository;

import com.solution.escort.domain.langdingpage.entity.LandingPageCompany;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

@Repository
@RequiredArgsConstructor
public class LandingPageCompanyRepository {

    private final EntityManager em;
    @Transactional
    public void save(LandingPageCompany landingPageCompany) {
        em.persist(landingPageCompany);
    }
}
