
---------------------------테이블, 테이블 내부에 대한 조작----------------
쿼리 : 셀렉트
dml : 인서트,업데이트,딜리트 -> 수행시 트랜젝션에 들어가 롤백가능
tcl : commit ,rollback , savepoint 


------------------------테이블 외부, 다른 객체 조작---------------------
ddl : creae,alter,drop,rename,truncate,comment  직접 영향을 주므로 
(auto commit 수행 -> 롤백 불가능 )


-----------------------보안, 권한 ,사용자 