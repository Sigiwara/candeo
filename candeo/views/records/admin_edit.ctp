	<?php echo $this->renderElement('checksource'); ?>
<h2>Edit Record</h2>
	<?php echo $form->create('Record');?>
	<?php echo $form->hidden('Record.id'); ?>
<ul>
	<li>
		<?php echo $form->input('Record.name', array('class' => 'text'))?>
		<?php echo $form->error('Record.name', 'A name is required.') ?>
	</li>
	<!--
		Auslagern ins model: mit callback "beforeSave" überprüfen welcher select ausgewählt wurde und anschliessend source_type einfügen.
		Select value immer bei einem tab wechsel auf 0 setzen!
		-->
	<li class="radiofield clear">
		<?php echo $form->radio('Record.source_type', array('Atomic' => 'Atomic', 'Biological' => 'Biological', 'Chemical' => 'Chemical', 'Waste' => 'Waste'), array('class' => 'radio')) ?>
	</li>
	<li id="AtomicSource">
		<?php echo $form->input('Record.atomic_id', array()) ?>
	</li>
	<li id="BiologicalSource">
		<?php echo $form->input('Record.biological_id') ?>
	</li>
	<li id="ChemicalSource">
		<?php echo $form->input('Record.chemical_id') ?>
	</li>
	<li class="clear">
		<?php echo $form->input('Record.amount', array('class' => 'text'))?>
		<?php echo $form->error('Record.amount', 'An amount is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Record.version', array('class' => 'text'))?>
		<?php echo $form->error('Record.version', 'A version is required.') ?>
	</li>
	<li class="clear">
		<?php echo $form->input('Record.institute_id') ?>
		<?php echo $form->error('Record.institute_id', 'An institute is required.') ?>
	</li>
	<li class="clear">
		<?php
			$tBuildings = array();
			foreach($buildings as $tBuilding){
				array_push($tBuildings, array($tBuilding['id'] => $tBuilding['name']));
			};
		?>
		<label for="RecordBuildingId">Building</label>
		<?php echo $form->select('Record.building_id', array($tBuildings), $this->data['Record']['building_id'], array(), false) ?>
		<?php echo $form->error('Record.building_id', 'An institute is required.') ?>
	</li>
	<li class="clear">
		<?php echo $form->input('Record.room', array('class' => 'text'))?>
		<?php echo $form->error('Record.room', 'A room is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Record.floor', array('class' => 'text'))?>
		<?php echo $form->error('Record.floor', 'A floor is required.') ?>
	</li>
	<li>
		<?php echo $form->input('Record.notes', array('class' => 'text'))?>
	</li>
</ul>
<div id="page_nav">
	<?php echo $form->end('Save')?>
	<?php echo $html->link('Cancel', '/buildings', array('class' => 'back')); ?>
</div>