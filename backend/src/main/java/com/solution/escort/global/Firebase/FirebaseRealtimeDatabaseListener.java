package com.solution.escort.global.Firebase;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseCredentials;
import com.google.firebase.database.*;
import org.springframework.beans.factory.annotation.Value;


import javax.annotation.PostConstruct;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.concurrent.CountDownLatch;
public class FirebaseRealtimeDatabaseListener {
    @Value("${FIREBASE.DATABASE.URL}")
    private String firebaseDatabaseUrl;

    @Value("${FIREBASE.DATABASE.PATH}")
    private String firebaseDatabasePath;

    @PostConstruct
    public void initFirebaseRealtimeDatabase() throws IOException, InterruptedException {
        FileInputStream serviceAccount = new FileInputStream("path/to/firebase-adminsdk.json");

        FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredential(FirebaseCredentials.fromCertificate(serviceAccount))
                .setDatabaseUrl(firebaseDatabaseUrl)
                .build();

        FirebaseApp.initializeApp(options);

        DatabaseReference firebaseDatabaseRef = FirebaseDatabase.getInstance().getReference(firebaseDatabasePath);

        firebaseDatabaseRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                // 데이터가 변경될 때마다 호출됩니다.
                // dataSnapshot에서 변경된 데이터를 읽어올 수 있습니다.
                System.out.println("Data changed: " + dataSnapshot.getValue());
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // 데이터 수신이 실패할 때 호출됩니다.
                System.out.println("Data receive failed: " + databaseError.getMessage());
            }
        });

        // Firebase Realtime Database의 데이터를 비동기적으로 가져오기 위해 CountDownLatch를 사용합니다.
        final CountDownLatch countDownLatch = new CountDownLatch(1);
        firebaseDatabaseRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                System.out.println("Data received: " + dataSnapshot.getValue());
                countDownLatch.countDown();
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                System.out.println("Data receive failed: " + databaseError.getMessage());
                countDownLatch.countDown();
            }
        });
        countDownLatch.await();
    }
}
