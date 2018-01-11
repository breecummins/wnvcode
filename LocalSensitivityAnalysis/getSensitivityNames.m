function outputnames = getSensitivityNames(nums);
	outputnames={};
	outputnames{1} = 'Prop -> any host';
	outputnames{2} = 'Prop -> left gp';
	outputnames{3} = 'Prop -> right gp';
	outputnames{4} = 'Average time to host';
	if exist('nums','var');
		outputnames = {outputnames{nums}};
	end
end %function	
