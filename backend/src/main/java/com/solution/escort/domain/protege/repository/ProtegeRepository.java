package com.solution.escort.domain.protege.repository;

import com.solution.escort.domain.protector.entity.Protector;
import com.solution.escort.domain.protege.entity.Protege;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProtegeRepository extends JpaRepository<Protege, Integer> {
    boolean existsByEmail(String email);

    boolean existsByFbId(String uId);

    Protege findByFbId(String uId);

    Protege findById(int id);




}
