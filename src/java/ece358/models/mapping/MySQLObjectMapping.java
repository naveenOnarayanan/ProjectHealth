/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ece358.models.mapping;

import java.lang.reflect.Field;
import java.util.List;

/**
 *
 * @author ZGaming
 */
public interface MySQLObjectMapping {
    List<Field> getIdFields();
}
