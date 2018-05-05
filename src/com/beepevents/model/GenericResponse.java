package com.beepevents.model;


public class GenericResponse {
	private boolean status;
	private String message;
	private String errorCode;
	
	public GenericResponse(){}

	public GenericResponse(boolean bool) {
		if (bool){
			this.status = true;
			this.message = "success";
		}else{
			this.status = false;
			this.message = "error";
		}
		
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	@Override
	public String toString() {
		return status + "|" + message + "|" + errorCode;
	}
	
}

