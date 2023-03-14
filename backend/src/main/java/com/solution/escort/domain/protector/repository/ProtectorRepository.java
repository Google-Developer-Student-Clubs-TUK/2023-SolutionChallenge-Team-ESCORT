package com.solution.escort.domain.protector.repository;

import com.solution.escort.domain.protector.entity.Protector;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProtectorRepository extends JpaRepository<Protector, Integer> {
    boolean existsByEmail(String email);

    @Query(value = "select deviceToken from Protector")
    List<String> selectAllDevicetoken();

    // firebase protector uId로 찾는 메소드(단건)
    Protector findByUId(String uId);

}
