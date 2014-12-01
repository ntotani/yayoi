
--------------------------------
-- @module Piece
-- @parent_module yayoi

--------------------------------
-- 
-- @function [parent=#Piece] getColor 
-- @param self
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Piece] getStatus 
-- @param self
-- @param #int param
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Piece] applyDamage 
-- @param self
-- @param #int damage
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Piece] setIdInMatch 
-- @param self
-- @param #int idInMatch
        
--------------------------------
-- 
-- @function [parent=#Piece] getTeam 
-- @param self
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Piece] getJob 
-- @param self
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Piece] getBaseStatus 
-- @param self
-- @param #int param
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Piece] applyChip 
-- @param self
-- @param #std::pair<int, int> chip
        
--------------------------------
-- 
-- @function [parent=#Piece] getMasterId 
-- @param self
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Piece] getIndividualStatus 
-- @param self
-- @param #int param
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Piece] getHp 
-- @param self
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Piece] isKing 
-- @param self
-- @return bool#bool ret (return value: bool)
        
--------------------------------
-- 
-- @function [parent=#Piece] getIdInMatch 
-- @param self
-- @return int#int ret (return value: int)
        
--------------------------------
-- 
-- @function [parent=#Piece] getPosition 
-- @param self
-- @return std::pair<int, int>#std::pair<int, int> ret (return value: std::pair<int, int>)
        
--------------------------------
-- 
-- @function [parent=#Piece] setMaster 
-- @param self
-- @param #int masterId
-- @param #int job
-- @param #int color
-- @param #map_table baseStatus
        
--------------------------------
-- @overload self, int, map_table, int, int, int, bool         
-- @overload self         
-- @function [parent=#Piece] Piece
-- @param self
-- @param #int masterId
-- @param #map_table individualStatus
-- @param #int team
-- @param #int row
-- @param #int col
-- @param #bool king

return nil
