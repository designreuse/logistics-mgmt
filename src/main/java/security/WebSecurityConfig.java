package security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.AuthenticationManagerConfiguration;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;


@Configuration
@EnableWebMvcSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{
@Autowired
public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception{
	auth
	.inMemoryAuthentication()
	.withUser("admin")
	.password("admin")
	.roles("Admin","User")
	.and()
		.withUser("user")
		.password("user")
		.roles("User");
}

}