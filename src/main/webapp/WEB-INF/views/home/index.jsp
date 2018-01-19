<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib tagdir="/WEB-INF/tags/template" prefix="template" %>

<script>
window.onload = function() {

	var selectedObject = null;

	var canvas = new fabric.Canvas('canvas');
	canvas.selectionColor = 'rgba(0,255,0,0.3)';
    canvas.selectionBorderColor = 'red';
    canvas.selectionLineWidth = 5;
    canvas.setBackgroundImage('img/darth-vader.jpeg', canvas.renderAll.bind(canvas));
    canvas.set({maxWidth:100,maxHeight:120});

	$('.objects input[type=radio]').on('change', function() {
		selectedObject = this.value;
		console.log(this.value);
		showInputs();
	});

	$('.form-inputs').on('submit', function() {
		switch(selectedObject) {
			case 'circle':
				setCircle();
				hideInputs();
				break; 
			case 'triangle':
				setTriangle();
				hideInputs();
				break;
			case 'square':
				setSquare();
				hideInputs();
				break;
		}
		return false;
	})
	
	var getInputsForm = function() {
		var attrs = $('.form-inputs').serializeArray().reduce(function(obj, item) {
			var value = item.value;
			if(value.match(/^-{0,1}\d+$/)) {
				value = parseInt(value);
			}
			obj[item.name] = value;
			return obj;
		}, {});
		return attrs;
	}

	var setCircle = function() {
		var attrs = getInputsForm();
		var top = attrs.width;
		var left = attrs.height;

		if(!top || !left) {
			return false;
		}
		
		var circle = new fabric.Circle({ radius: 50, fill: '#f55', top: top, left: left });
		canvas.add(circle);
	}

	var setSquare = function() {
		var attrs = getInputsForm();
		var top = attrs.width;
		var left = attrs.height;

		if(!top || !left) {
			return false;
		}
		
		var square = new fabric.Rect({ left: left, top: top, fill: '#f0f', width: 50, height: 50 });
		canvas.add(square);
	}

	var setTriangle = function() {
		var attrs = getInputsForm();
		var top = attrs.width;
		var left = attrs.height;

		if(!top || !left) {
			return false;
		}
		
		var triangle = new fabric.Triangle({
		    left: left,
		    top: top,
		    strokeWidth: 1,
		    width: 50,
		    height: 50,
		    stroke: 'black',
		    fill:'white',
		    selectable: true,
		    originX: 'center'
		});
		canvas.add(triangle);
	}

	var hideInputs = function() {
		$('.form-inputs').hide();
		selectedObject = null;
		$('input[name="width"]').val(null);
		$('input[name="height"]').val(null);
		$('.objects .active').removeClass('active');
	}

	var showInputs = function() {
		$('.form-inputs').show();
	}
};
</script>

<template:admin>
<jsp:attribute name="extraStyles">
<link rel="stylesheet" href="<c:url value='/assets/css/pagination/jqpagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/assets/css/index/index.css'/>" />
</jsp:attribute>
<jsp:attribute name="extraScripts">
<script src="<c:url value='/assets/js/jquery.jqpagination.js'/>"></script>
</jsp:attribute>
<jsp:body> 
	<div class="container min-container">
		<p>MAIN IMAGE - Testing - Energias</p>
		<div class="canvas-outer">
			<canvas id="canvas" class="canvas" width="450" height="450"></canvas>
		</div>
		<div class="func-add-objects">
			<div class="btn-group objects" data-toggle="buttons">
				<label class="btn btn-primary">
			  		<input type="radio" name="options" value="circle" autocomplete="off"> Circulo
				</label>
				<label class="btn btn-primary">
			  		<input type="radio" name="options" value="square" autocomplete="off"> Quadrado
				</label>
				<label class="btn btn-primary">
			  		<input type="radio" name="options" value="triangle" autocomplete="off"> Triângulo
				</label>
			</div>
			
			<form class="form-inputs">
				<div class="row">
					<div class="col-md-5">
						<div class="form-group">
							<label for="usr">Informe a distância da parte de cima da imagem (em px)</label>
							<input name="width" type="number" class="form-control" id="usr">
					    </div>
					</div>
					
					<div class="col-md-5">
						<div class="form-group">
							<label for="usr">Informe a distância da esquerda da imagem (em px):</label>
							<input name="height" type="number" class="form-control" id="usr">
					    </div>
					</div>
					
					<div class="col-md-2">
						<button id="btn_add" type="submit" class="btn btn-default">Adicionar</button>
					</div>
				</div>
			</form>
		</div>
		<!-- <img class="img-responsive" src="img/darth-vader.jpeg" alt="MAIN IMAGE" />  -->
	</div>
</jsp:body>
</template:admin>
