package com.xworkz.model.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.xworkz.model")
public class CoreConfiguration implements WebMvcConfigurer {

    public CoreConfiguration(){
        System.out.println("core config object created");
    }


    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("/assets/");
        registry.addResourceHandler("/js/**")
                .addResourceLocations("/js/");
    }



    @Bean
    public ViewResolver viewResolver(){
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }


    @Bean
    public DataSource getDataSource(){
        DriverManagerDataSource driverManagerDataSource =new DriverManagerDataSource();
        driverManagerDataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        driverManagerDataSource.setUrl("jdbc:mysql://localhost:3306/model_db");
        driverManagerDataSource.setUsername("root");
        driverManagerDataSource.setPassword("0000");
        return driverManagerDataSource;
    }

    public Properties getJpaProperties(){
        Properties properties = new Properties();
        properties.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
        properties.setProperty("hibernate.show_sql", "true");
        properties.setProperty("hibernate.hbm2ddl.auto", "update");
        return properties;

    }

    @Bean
    public LocalContainerEntityManagerFactoryBean getLocalEntityManagerFactoryBean(){
        LocalContainerEntityManagerFactoryBean localContainerEntityManagerFactory = new LocalContainerEntityManagerFactoryBean();

        localContainerEntityManagerFactory.setDataSource(getDataSource());
        localContainerEntityManagerFactory.setPackagesToScan("com.xworkz.model.entity");
        localContainerEntityManagerFactory.setJpaProperties(getJpaProperties());
        localContainerEntityManagerFactory.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        return localContainerEntityManagerFactory;
    }


}
