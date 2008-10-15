<h2><?php echo $institute['Institute']['name']?></h2>
	<?php echo $form->create('Record');?>
	<table>
		<tr><th>Name</th><th>Symbol</th><th>Amount</th><th>Building</th></tr>
		<?php
			$i = 0;
			foreach ($fields as $field) {
				echo $form->hidden($i.'.name', array('value' => $field['Field']['name']));
				echo $form->hidden($i.'.institute_id', array('value' => $institute['Institute']['id']));
				echo $form->hidden($i.'.field_id', array('value' => $field['Field']['id']))
				?>
				<tr>
					<td><?php echo $field['Field']['name'] ?></td>
					<td><?php echo $field['Field']['symbol'] ?></td>
					<td>
						<?php echo $form->input($i.'.amount', array('class' => 'text', 'label'=>false))?>
						<?php echo $form->error($i.'.amount', 'An amount is required.') ?>
					</td>
					<td>
						<?php echo $form->input($i.'.building_id', array('label'=>false)) ?>
						<?php echo $form->error($i.'.building_id', 'An building is required.') ?>
					</td>
				</tr>
			<?php
				$i++;
			}
		?>
	</table>
<div id="page_nav">
	<?php echo $form->end('Submit');?>
	<?php echo $html->link('Cancel', array('action'=>'index',),  array('class'=>'back')); ?>
</div>