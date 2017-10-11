# study-online
spring framework를 공부하며 예외, 전문 처리 등 기본 기능 구현해보기

## 기능
study-online -> study -> fw 의 Dependency 관계로 구성되며 study-online에는 스프링 설정 파일들이 위치한다.

### 1. mvc-context-servlet.xml
#### *mvc:annotation-driven*
@requestBody, @responseBody 어노테이션을 만났을 때의 처리를 어떻게 하는지에 대한 설정을 하는 것으로, 설정을 안하면 스프링에서 알아서 JSON에서 key, value로 꺼내서 VO에 넣는 작업을 해줌. 하지만 자체 전문 형식을 사용하려면 메시지 컨버터로 사용할 빈을 정의해줘야 함. (StudyJsonMessageConverter)

```
<mvc:annotation-driven validator="validator">	
  <mvc:message-converters>
    <ref bean="studyJsonMessageConverter" />
  </mvc:message-converters>
</mvc:annotation-driven>
```


#### *bean id="studyJsonMessageConverter" class="study.fw.core.binding.StudyJsonMessageConverter"*
studyJsonMessageConverter 메시지 컨버터는 MappingJackson2HttpMessageConverter 를 상속받아서 구현함. 
MappingJackson2HttpMessageConverter 는 http 바디부에 있는 Json형태의 메시지를 @RequestBody 다음에 정의된 오브젝트 형식으로 변환하는 작업을 한다.
~~~studyJsonMessageConverter 에 property로 messageValidators 들이 설정될텐데, 메시지 컨버팅(read에서 처리) 후, messagevalidators 들에 의해서 메시지 validation 체크를 하게 될 것이다.~~~
```
<bean id="studyJsonMessageConverter" class="study.fw.core.binding.StudyJsonMessageConverter">
</bean>
```


#### *aop:aspectj-autoproxy*
~~~controller 앞단에 aop를 건 것인데, http요청이 들어온 것의 정보를 컨텍스트홀더에 넣는 작업을 하게 될 것이다.~~~
```
<aop:aspectj-autoproxy />
<bean id="controllerClassNameInfo" class="study.fw.online.aspect.StudyControllerClassNameAdvice" />
```


#### *context:component-scan*
어노테이션으로 설정된 controller, service, repository 등을 찾아서 빈 오브젝트로 생성해서 메모리에 올림
```
<context:component-scan base-package="study.fw.online.aspect" use-default-filters="false" name-generator="study.fw.core.spring.bean.FullyQualifiedBeanNameGenerator">
  <context:include-filter type="annotation" expression="org.springframework.web.bind.annotation.ControllerAdvice" />
</context:component-scan>
<context:component-scan base-package="study" use-default-filters="false" name-generator="study.fw.core.spring.bean.FullyQualifiedBeanNameGenerator" resource-pattern="**/*Controller.class">
  <context:include-filter type="annotation" expression="org.springframework.stereotype.Controller" />
</context:component-scan>
<context:component-scan base-package="study" use-default-filters="false" name-generator="study.fw.core.spring.bean.FullyQualifiedBeanNameGenerator" resource-pattern="**/*Service.class">
  <context:include-filter type="annotation" expression="org.springframework.stereotype.Service" />
</context:component-scan>
<context:component-scan base-package="study" use-default-filters="false" name-generator="study.fw.core.spring.bean.FullyQualifiedBeanNameGenerator" resource-pattern="**/*Dao.class">
  <context:include-filter type="annotation" expression="org.springframework.stereotype.Repository" />
</context:component-scan>
```
