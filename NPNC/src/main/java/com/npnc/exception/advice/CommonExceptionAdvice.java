package com.npnc.exception.advice;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class CommonExceptionAdvice {
	
	//�Ϲ����� ���� �߻���
	@ExceptionHandler(Exception.class)
	public String except(Model model) {
		model.addAttribute("msg","��û ó���� ������ �߻��߽��ϴ�");
		return "common/error_page";
	}
	//404 ���� �߻���
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(Model model) {
		model.addAttribute("msg","�������� �ʴ� �������Դϴ�");
		return "common/error_page";
	}
}
