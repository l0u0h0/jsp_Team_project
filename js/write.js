	$(function(){
		$('.upload_text').val('미리보여줄 텍스트.');
		$('.input_file').change(function(){
			var i = $(this).val();
			$('.upload_text').val(i);
		});
	});

