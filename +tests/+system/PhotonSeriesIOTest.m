classdef PhotonSeriesIOTest < tests.system.PyNWBIOTest
    methods
        function addContainer(testCase, file) %#ok<INUSL>
            dev = types.core.Device();
            
            oc = types.core.OpticalChannel( ...
                'description', 'a fake OpticalChannel', ...
                'emission_lambda', 3.14);
            ip = types.core.ImagingPlane( ...
                'description', 'a fake ImagingPlane', ...
                'optchan1', oc, ...
                'device', types.untyped.SoftLink('/general/devices/test_device_1'), ...
                'excitation_lambda', 6.28, ...
                'imaging_rate', 2.718, ...
                'indicator', 'GFP', ...
                'location', 'somewhere in the brain',...
                'manifold', zeros(3,1),...
                'reference_frame', 'manifold ref');
            
            tps = types.core.TwoPhotonSeries( ...
                'data', int32([0:9;10:19]) .', ...
                'imaging_plane', types.untyped.SoftLink('/general/optophysiology/imgpln1'), ...
                'data_unit', 'image_unit', ...
                'format', 'raw', ...
                'field_of_view', [2, 2, 5] .', ...
                'pmt_gain', 1.7, ...
                'scan_line_rate', 3.4, ...
                'timestamps', (0:9) .', ...
                'dimension', 2);
            
            file.general_devices.set('test_device_1', dev);
            file.general_optophysiology.set('imgpln1', ip);
            file.acquisition.set('test_2ps', tps);
        end
        
        function c = getContainer(testCase, file) %#ok<INUSL>
            c = file.acquisition.get('test_2ps');
        end
    end
end

