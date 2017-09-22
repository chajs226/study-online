<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
response.setStatus(HttpServletResponse.SC_OK);
%>
{
  "header": {
    "systemid": "",
    "user": "",
    "ip": "",
    "dataFlag": "",
    "version": 0,
    "source": "",
    "bizCode": "",
    "debug": 0,
    "customerMessage": "",
    "messageId": "common.error.service_not_found",
    "message": "존재하지 않는 서비스입니다. 확인 후 다시 시도 해 주시기 바랍니다.",
    "resultCode": "F",
    "bizResultCode": null,
    "trno": 1,
    "dbName": ""
  }
}