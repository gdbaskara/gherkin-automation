package karate;

import com.intuit.karate.junit5.Karate;

public class RunLoginTest {
    @Karate.Test
    Karate testLogin() {
        return Karate.run("classpath:features/login.feature");
    }
}
