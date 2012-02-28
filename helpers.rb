helpers do
	def _text(args)
		'<div class="control-group'+(args[:error] ? ' error' : '' )+'">
			<label class="control-label" for="'+args[:name]+'">'+args[:label]+(args[:required]?'<sup>*</sup>':'')+'</label>
			<div class="controls">
				<input type="text" class="input-xlarge" id="'+args[:name]+'" name="'+args[:name]+'"
				'+(args[:placeholder] ? 'placeholder="'+args[:placeholder]+'"':'')+'
				'+(args[:value] ? 'value="'+args[:value]+'"':'')+'
				>
				'+(args[:error] ? '<p class="help-block"><strong>'+args[:error]+'</strong></p>':'')+'
				'+(args[:help] ? '<p class="help-block">'+args[:help]+'</p>':'')+'
			</div>
		</div>'
	end
	def _textarea(args)
		'<div class="control-group'+(args[:error] ? ' error' : '')+'">
			<label class="control-label" for="'+args[:name]+'">'+args[:label]+(args[:required]?'<sup>*</sup>':'')+'</label>
			<div class="controls">
				<textarea class="input-xlarge" id="'+args[:name]+'" name="'+args[:name]+'"
				'+(args[:placeholder] ? 'placeholder="'+args[:placeholder]+'"':'')+'
				>'+(args[:value] ? args[:value]:'')+'</textarea>
				'+(args[:error] ? '<p class="help-block"><strong>'+args[:error]+'</strong></p>':'')+'
				'+(args[:help] ? '<p class="help-block">'+args[:help]+'</p>':'')+'
			</div>
		</div>'
	end
	def _button(args)
		'<div class="control-group'+(args[:error] ? ' error' : '')+'">
			<label class="control-label" for="'+(args[:name]||='')+'">'+(args[:label]||='')+'</label>
			<div class="controls">
				<button class="btn'+(args[:class] ? ' '+args[:class]:'')+'"
				'+(args[:type] ? ' type="'+args[:type]+'"':'')+'
				'+(args[:name] ? ' id="'+args[:name]+'"':'')+'
				>'+(args[:text] ? args[:text]:'')+'</button>
			</div>
		</div>'
	end
end
