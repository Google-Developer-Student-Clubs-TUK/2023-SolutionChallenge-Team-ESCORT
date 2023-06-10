package com.solution.escort.domain.langdingpage.repository;

import com.solution.escort.domain.langdingpage.entity.LandingPageUser;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;


@Repository
@RequiredArgsConstructor
public  class LandingPageUserRepository {


    private final EntityManager em;


    @Transactional
    public void save(LandingPageUser landingPageUser) {
        em.persist(landingPageUser);
    }

}
