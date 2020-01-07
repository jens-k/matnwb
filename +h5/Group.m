classdef Group < h5.interface.HasSubObjects...
        & h5.interface.HasAttributes...
        & h5.interface.IsObject
    %GROUP HDF5 Group
    
    methods (Static)
        function Group = create(Parent, name)
            pid = 'H5P_DEFAULT';
            
            Group = h5.Group(...
                H5G.create(Parent.get_id(), name, pid, pid, pid),...
                name);
        end
        
        function Group = open(Parent, name)
            Group = h5.Group(H5G.open(Parent.get_id(), name), name);
        end
    end
    
    properties (Access = private)
        id;
    end
    
    properties (SetAccess = private)
        name;
    end
    
    methods % lifecycle
        function obj = Group(name, id)
            obj.id = id;
            obj.name = name;
        end
        
        function delete(obj)
            H5G.close(obj.id);
        end
    end
    
    methods % HasId
        function id = get_id(obj)
            id = obj.id;
        end
    end
end

